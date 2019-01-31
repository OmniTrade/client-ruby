# frozen_string_literal: true

module OmniTradeAPI
  describe Hash do
    describe '#symbolize_keys' do
      let(:hash) { { "string_key" => "string_value" } }

      it 'parses String keys to Symbols' do
        expect(hash.symbolize_keys.keys.first).to be_a(Symbol)
      end
    end

    describe 'transform_keys' do
      let(:hash) { { "string_key" => "string_value" } }

      context 'if no block is given' do
        it 'parses the keys into an Enumerator' do
          expect(hash.transform_keys).to be_a(Enumerator)
        end
      end

      context 'if a block is given' do
        it 'parses the keys the given block' do
          expect(hash.transform_keys { [] }.keys.first).to be_a(Array)
        end
      end
    end
  end
end
