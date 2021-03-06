describe Travis::Yml::Schema::Def::Android, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:android] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_android,
        title: 'Language Android',
        type: :object,
        properties: {
          jdk: {
            '$ref': '#/definitions/type/jdks',
            only: {
              language: [
                'android'
              ]
            },
            except: {
              os: [
                'osx'
              ]
            }
          },
          android: {
            type: :object,
            properties: {
              components: {
                '$ref': '#/definitions/type/strs'
              },
              licenses: {
                '$ref': '#/definitions/type/strs'
              }
            },
            additionalProperties: false,
            only: {
              language: [
                'android'
              ]
            }
          }
        },
        normal: true
    )
  end
end
