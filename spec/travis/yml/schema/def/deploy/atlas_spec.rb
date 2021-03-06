describe Travis::Yml::Schema::Def::Deploy::Atlas do
  subject { Travis::Yml.schema[:definitions][:deploy][:atlas] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_atlas,
        title: 'Deploy Atlas',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'atlas'
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
              token: {
                '$ref': '#/definitions/type/secure'
              },
              app: {
                type: :string
              },
              exclude: {
                '$ref': '#/definitions/type/strs'
              },
              include: {
                '$ref': '#/definitions/type/strs'
              },
              address: {
                type: :string
              },
              metadata: {
                '$ref': '#/definitions/type/strs'
              },
              debug: {
                type: :boolean
              },
              vcs: {
                type: :boolean
              },
              paths: {
                '$ref': '#/definitions/type/strs'
              },
              args: {
                type: :string
              },
              version: {
                type: :boolean
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
              'atlas'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
