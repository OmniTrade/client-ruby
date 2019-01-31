# frozen_string_literal: true

module OmniTradeAPI
  describe Object do
    describe '#to_param' do
      it 'parses the object into a String' do
        expect(described_class.to_param).to be_a(String)
      end
    end

    describe '#to_query(key)' do
      let(:key) { 'key' }

      it 'parses the object into a query String' do
        expect(described_class.to_query(key)).to include(key)
      end
    end
  end

  describe NilClass do
    describe 'to_param' do
      it 'returns itself as a string' do
        expect(described_class.to_param).to eq(described_class.to_s)
      end
    end
  end

  describe TrueClass do
    describe 'to_param' do
      it 'returns itself as a string' do
        expect(described_class.to_param).to eq(described_class.to_s)
      end
    end
  end

  describe FalseClass do
    describe 'to_param' do
      it 'returns itself as a string' do
        expect(described_class.to_param).to eq(described_class.to_s)
      end
    end
  end

  describe Array do
    let(:array) { ['element0', 'element1'] }

    describe '#to_param' do
      it 'parses the array into a String joining the elements with a /' do
        expect(array.to_param).to eq('element0/element1')
      end
    end

    describe '#to_query(key)' do
      let(:key) { 'key' }

      it 'parses the given Array into a query String with a key' do
        expect(array.to_query(key)).to eq('key%5B%5D=element0&key%5B%5D=element1')
      end
    end
  end

  describe Hash do
    let(:hash) { { key1: 'value1', key2: 'value2' } }

    describe '#to_query(key)' do
      let(:key) { 'key' }

      it 'parses the given Hash into a query String with a key' do
        expect(hash.to_query(key)).to eq('key%5Bkey1%5D=value1&key%5Bkey2%5D=value2')
      end
    end
  end
end
