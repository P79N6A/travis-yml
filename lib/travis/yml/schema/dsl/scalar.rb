# frozen_string_literal: true
require 'travis/yml/schema/dsl/node'

module Travis
  module Yml
    module Schema
      module Dsl
        class Scalar < Node
          register :scalar

          def self.type
            :scalar
          end

          def default(value, opts = nil)
            value = { value: value } unless value.is_a?(Hash)
            value = value.merge(opts) if opts
            value[:value] = value[:value].to_s if str?
            node.set :defaults, [value.merge(support(value))]
          end

          def strict(obj = true)
            node.opts[:strict] = obj
          end

          def support(value)
            support = only(value, :only, :except)
            support.map { |key, opts| [key, to_strs(opts)] }.to_h
          end

          # Accepts:
          #
          #    values 'ruby', 'python'
          #
          #    value 'osx', alias: ['ios', 'macOS'], deprectated: true, only: { language: 'objective-c' }
          #
          #    { value: 'osx', alias: ['ios'], ... }
          #
          # and normalizes to:
          #
          #    { osx: { alias: ['ios'], deprecated: true }
          #
          def values(*objs)
            objs = objs.flatten.compact

            if objs.empty?
              return
            elsif objs.first.is_a?(Hash)
              node.set(:enum, to_enum(objs))
              node.set(:values, merge(compact(to_vals(remap(objs)))))
            else
              opts = objs.last.is_a?(Hash) ? objs.pop : {}
              return values(*objs.map { |obj| opts.merge(value: obj) })
            end
          end
          alias value values

          REMAP = {
            alias: :aliases
          }

          def remap(objs)
            objs.map { |obj| obj.map { |key, obj| [REMAP[key] || key, obj] }.to_h }
          end

          def to_enum(objs)
            to_strs(objs.map { |obj| obj[:value] })
          end

          def to_vals(objs)
            keys = objs.map { |obj| obj[:value] }
            keys = keys.map { |key| key.is_a?(String) ? key.to_sym : key }
            objs = keys.zip(objs)
            to_strs(objs.map { |key, obj| [key, except(obj, :value)] }.to_h)
          end
        end
      end
    end
  end
end
