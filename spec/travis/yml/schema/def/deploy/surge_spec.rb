describe Travis::Yml::Schema::Def::Deploy::Surge do
  subject { Travis::Yml.schema[:definitions][:deploy][:surge] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_surge,
        title: 'Deploy Surge',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'surge'
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
              login: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              token: {
                '$ref': '#/definitions/type/secure',
              },
              project: {
                type: :string
              },
              domain: {
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
              'surge'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
