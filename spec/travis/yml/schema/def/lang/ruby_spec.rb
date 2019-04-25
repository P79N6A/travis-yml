describe Travis::Yml::Schema::Def::Ruby, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:ruby] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_ruby,
        title: 'Language Ruby',
        type: :object,
        properties: {
          rvm: {
            '$ref': '#/definitions/type/strs'
          },
          gemfile: {
            '$ref': '#/definitions/type/strs'
          },
          jdk: {
            anyOf: [
              {
                type: :array,
                items: {
                  type: :string
                },
                flags: [
                  :expand
                ],
                normal: true
              },
              {
                type: :string
              }
            ],
            flags: [
              :expand
            ]
          },
          bundler_args: {
            type: :string
          }
        },
        normal: true,
        keys: {
          rvm: {
            aliases: [
              :ruby
            ],
            only: {
              language: [
                'ruby'
              ]
            }
          },
          gemfile: {
            aliases: [
              :gemfiles
            ],
            only: {
              language: [
                'ruby'
              ]
            }
          },
          jdk: {
            only: {
              language: [
                'ruby'
              ]
            },
            except: {
              os: [
                'osx'
              ]
            }
          },
          bundler_args: {
            only: {
              language: [
                'ruby'
              ]
            }
          }
        }
      )
    end
  end
end