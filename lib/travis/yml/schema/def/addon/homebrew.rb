# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Homebrew < Addon
            register :homebrew

            def define
              prefix :packages

              map :update,   to: :bool
              map :packages, to: :seq
              map :casks,    to: :seq
              map :taps,     to: :seq
              map :brewfile, to: :str

              super
            end
          end
        end
      end
    end
  end
end
