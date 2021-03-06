# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          def self.provider_names
            consts = Deploy.registry.values
            consts = consts.select { |const| const < Deploy }
            consts.map(&:registry_key).sort.compact
          end

          class Deploys < Dsl::Seq
            register :deploys

            def define
              normal
              type Providers
              export
            end
          end

          class Providers < Dsl::Any
            registry :deploy
            register :providers

            def define
              normal
              add *Def::Deploy.provider_names
              detect :provider
              export
            end
          end

          class Deploy < Dsl::Map
            registry :deploy

            def before_define
              normal

              prefix :provider

              map :provider,      to: :str, values: registry_key, required: true, strict: true
              map :on,            to: :conditions, alias: :true
              map :run,           to: :str
              map :allow_failure, to: :bool
              map :skip_cleanup,  to: :bool
              map :edge,          to: :edge

              # so called option specific branch hashes are valid, but
              # deprecated according to travis-build. e.g.:
              #
              #     provider: lambda
              #     function_name:
              #       develop: foo
              #       production: bar
              #
              # map :'.*', to: :branches

              export
            end
          end

          class Conditions < Dsl::Map
            registry :deploy
            register :conditions

            def define
              normal
              prefix :branch, only: :str

              map :os
              map :branch,       to: :branches
              map :repo,         to: :str
              map :condition,    to: :seq, type: :str
              map :all_branches, to: :bool
              map :tags,         to: :bool

              include :support

              export
            end
          end

          class Branches < Dsl::Any
            registry :deploy
            register :branches

            def define
              add :seq, normal: true
              add Branch
              export
            end
          end

          class Branch < Dsl::Map
            registry :deploy
            register :branch

            def define
              normal
              strict false
              # branch specific option hashes to be removed in v1.1.0
              deprecated :branch_specific_option_hash
            end
          end

          class Edge < Dsl::Map
            registry :deploy
            register :edge

            def define
              edge

              map :enabled, to: :bool
              map :source, to: :str
              map :branch, to: :str

              change :enable
              export
            end
          end
        end
      end
    end
  end
end

require 'travis/yml/schema/def/deploy'
require 'travis/yml/schema/def/deploy/anynines'
require 'travis/yml/schema/def/deploy/atlas'
require 'travis/yml/schema/def/deploy/azure_web_apps'
require 'travis/yml/schema/def/deploy/bintray'
require 'travis/yml/schema/def/deploy/bitballoon'
require 'travis/yml/schema/def/deploy/bluemix_cloudfoundry'
require 'travis/yml/schema/def/deploy/boxfuse'
require 'travis/yml/schema/def/deploy/cargo'
require 'travis/yml/schema/def/deploy/catalyze'
require 'travis/yml/schema/def/deploy/chef_supermarket'
require 'travis/yml/schema/def/deploy/cloud66'
require 'travis/yml/schema/def/deploy/cloudfiles'
require 'travis/yml/schema/def/deploy/cloudfoundry'
require 'travis/yml/schema/def/deploy/codedeploy'
require 'travis/yml/schema/def/deploy/deis'
require 'travis/yml/schema/def/deploy/elasticbeanstalk'
require 'travis/yml/schema/def/deploy/engineyard'
require 'travis/yml/schema/def/deploy/firebase'
require 'travis/yml/schema/def/deploy/gae'
require 'travis/yml/schema/def/deploy/gcs'
require 'travis/yml/schema/def/deploy/hackage'
require 'travis/yml/schema/def/deploy/hephy'
require 'travis/yml/schema/def/deploy/heroku'
require 'travis/yml/schema/def/deploy/lambda'
require 'travis/yml/schema/def/deploy/launchpad'
require 'travis/yml/schema/def/deploy/npm'
require 'travis/yml/schema/def/deploy/openshift'
require 'travis/yml/schema/def/deploy/opsworks'
require 'travis/yml/schema/def/deploy/packagecloud'
require 'travis/yml/schema/def/deploy/pages'
require 'travis/yml/schema/def/deploy/puppetforge'
require 'travis/yml/schema/def/deploy/pypi'
require 'travis/yml/schema/def/deploy/releases'
require 'travis/yml/schema/def/deploy/rubygems'
require 'travis/yml/schema/def/deploy/s3'
require 'travis/yml/schema/def/deploy/scalingo'
require 'travis/yml/schema/def/deploy/script'
require 'travis/yml/schema/def/deploy/snap'
require 'travis/yml/schema/def/deploy/surge'
require 'travis/yml/schema/def/deploy/testfairy'
require 'travis/yml/schema/def/deploy/transifex'
