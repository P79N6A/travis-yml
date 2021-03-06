describe Travis::Yml::Schema::Def::Scala, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:scala] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_scala,
        title: 'Language Scala',
        type: :object,
        properties: {
          scala: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'scala'
              ]
            }
          },
          jdk: {
            '$ref': '#/definitions/type/jdks',
            only: {
              language: [
                'scala'
              ]
            },
            except: {
              os: [
                'osx'
              ]
            }
          },
          sbt_args: {
            type: :string,
            only: {
              language: [
                'scala'
              ]
            }
          }
        },
        normal: true
    )
  end
end
