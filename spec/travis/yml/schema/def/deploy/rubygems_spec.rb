describe Travis::Yml::Schema::Def::Deploy::Rubygems do
  subject { Travis::Yml.schema[:definitions][:deploy][:rubygems] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_rubygems,
        title: 'Deploy Rubygems',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'rubygems'
                ],
                strict: true
              },
              on: {
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
              },
              run: {
                type: :string
              },
              allow_failure: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/deploy/edge'
              },
              api_key: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*': {
                        '$ref': '#/definitions/type/secure'
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/type/secure'
                  }
                ]
              },
              username: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*': {
                        '$ref': '#/definitions/type/secure',
                        # strict: false
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/type/secure',
                    # strict: false
                  }
                ]
              },
              password: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*': {
                        '$ref': '#/definitions/type/secure'
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/type/secure'
                  }
                ]
              },
              gem: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*': {
                        type: :string
                      }
                    }
                  },
                  {
                    type: :string
                  }
                ]
              },
              file: {
                type: :string
              },
              gemspec: {
                type: :string
              },
              gemspec_glob: {
                type: :string
              },
              host: {
                type: :string
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider
            },
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'rubygems'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
