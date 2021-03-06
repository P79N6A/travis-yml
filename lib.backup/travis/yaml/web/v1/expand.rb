# frozen_string_literal: true
require 'oj'
require 'travis/yaml/web/route'
require 'travis/yaml/web/v1/decorators/error'
require 'travis/yaml/web/v1/decorators/matrix'

module Travis::Yaml::Web
  module V1
    class Expand
      include Route

      def post(env)
        req = Rack::Request.new(env)
        body = req.body.read
        config = Oj.load(body, symbol_keys: true, mode: :strict, empty_string: false)
        rows = Travis::Yaml.matrix(config).rows

        [200, headers, body(Decorators::Matrix, rows)]
      rescue Oj::Error, EncodingError => error
        [400, headers, body(Decorators::Error, error)]
      end
    end
  end
end
