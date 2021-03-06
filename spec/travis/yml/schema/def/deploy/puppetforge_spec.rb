describe Travis::Yml::Schema::Def::Deploy::Puppetforge do
  subject { Travis::Yml.schema[:definitions][:deploy][:puppetforge] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_puppetforge,
        title: 'Deploy Puppetforge',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'puppetforge'
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
              user: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              url: {
                type: :string
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider
            },
            required: [
              :provider,
              :user,
              :password
            ]
          },
          {
            type: :string,
            enum: [
              'puppetforge'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
