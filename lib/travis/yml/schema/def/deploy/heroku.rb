# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # https://github.com/travis-ci/dpl#heroku
          # dpl readme says it's api-key, our docs say it's api_key
          # dpl readme does not mention the buildpack
          class Heroku < Deploy
            register :heroku

            def define
              map :strategy,  to: :heroku_strategy
              map :api_key,   to: :map, type: :secure
              map :username,  to: :secure
              map :password,  to: :secure
              map :app,       to: :map, type: :str
              map :git,       to: :str
              map :run,       to: :seq
              # map :buildpack, to: :str
            end
          end

          class HerokuStrategy < Dsl::Str
            register :heroku_strategy

            def define
              default :api
              value :api
              value :git
            end
          end
        end
      end
    end
  end
end

