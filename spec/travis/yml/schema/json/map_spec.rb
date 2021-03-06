describe Travis::Yml::Schema::Json::Map do
  let(:node) { Travis::Yml::Schema::Dsl::Map.new(nil, opts) }
  let(:opts) { {} }

  subject { described_class.new(node.node) }

  describe 'max_size' do
    let(:opts) { { max_size: 1 } }

    it do
      should have_schema(
        type: :object,
        maxProperties: 1
      )
    end
  end

  describe 'strict' do
    describe 'default' do
      it do
        should have_schema(
          type: :object,
        )
      end
    end

    describe 'strict (given true)' do
      let(:opts) { { strict: true } }

      it do
        should have_schema(
          type: :object,
        )
      end
    end

    describe 'strict (given false)' do
      let(:opts) { { strict: false } }

      it do
        should have_schema(
          type: :object,
        )
      end
    end
  end

  describe 'required' do
    before { node.map :foo, to: :str, required: true }

    it do
      should have_schema(
        type: :object,
        additionalProperties: false,
        properties: {
          foo: {
            type: :string
          }
        },
        required: [:foo]
      )
    end
  end

  describe 'unique' do
    before { node.map :foo, to: :str, unique: true }

    it do
      should have_schema(
        type: :object,
        additionalProperties: false,
        properties: {
          foo: {
            type: :string,
            unique: true
          }
        },
      )
    end
  end

  describe 'given a type' do
    let(:opts) { { type: :str } }

    it do
      should have_schema(
        type: :object,
        patternProperties: {
          '.*': {
            type: :string
          }
        }
      )
    end
  end

  describe 'given types' do
    let(:opts) { { type: [:map, :secure] } }

    it do
      should have_schema(
        type: :object,
        patternProperties: {
          '.*': {
            anyOf: [
              {
                type: :object
              },
              {
                '$id': :secure,
                anyOf: [
                  {
                    type: :object,
                    properties: {
                      secure: {
                        type: :string
                      }
                    },
                    additionalProperties: false,
                    maxProperties: 1,
                    normal: true
                  },
                  {
                    type: :string,
                    normal: true
                  }
                ]
              },
            ]
          }
        }
      )
    end
  end
end
