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
    describe '#to_param' do
      subject { nil.to_param }

      it { is_expected.to eq('') }
    end
  end

  describe TrueClass do
    describe '#to_param' do
      subject { true.to_param }

      it { is_expected.to eq('true') }
    end
  end

  describe FalseClass do
    describe '#to_param' do
      subject { false.to_param }

      it { is_expected.to eq('false') }
    end
  end

  describe Array do
    describe '#to_param' do
      let(:array) {%w(element0 element1)}

      it 'parses the array into a String joining the elements with a /' do
        expect(array.to_param).to eq('element0/element1')
      end
    end

    describe '#to_query(key)' do
      let(:key) { 'key' }

      subject { array.to_query(key) }

      context 'When array is empty' do
        let(:array) { [] }

        it { is_expected.to eq("key%5B%5D=") }
      end

      context 'When array is not empty' do
        let(:array) {%w(element0 element1)}

        it { is_expected.to eq('key%5B%5D=element0&key%5B%5D=element1') }
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
