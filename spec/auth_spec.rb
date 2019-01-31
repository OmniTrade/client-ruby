# frozen_string_literal: true

require 'spec_helper'

module OmniTradeAPI
  describe Auth do
    let(:access_key) { '123456' }
    let(:secret_key) { '655321' }

    subject { described_class.new(access_key, secret_key) }

    describe '#signed_challenge' do
      let(:challenge) { 'challenge' }

      it 'returns an auth hash' do
        expect(subject.signed_challenge(challenge)).to include(:auth)
      end
    end

    describe '#signed_params' do
      let(:verb) { 'POST' }
      let(:path) { '/path/to/somewhere' }
      let(:params) { { param: 'param' } }

      it 'returns the params with a signature' do
        expect(subject.signed_params(verb, path, params)).to include(:signature)
      end
    end

    describe '#sign' do
      let(:verb) { 'POST' }
      let(:path) { '/path/to/somewhere' }
      let(:params) { { param: 'param' } }
      let(:sha_256_length) { 64 }

      it 'returns a SHA256 signature' do
        expect(subject.sign(verb, path, params).length).to eq(sha_256_length)
      end
    end

    describe '#payload' do
      let(:verb) { 'POST' }
      let(:path) { '/path/to/somewhere' }
      let(:params) { { param: 'param' } }

      it 'returns a payload string with the given arguments' do
        expect(subject.payload(verb, path, params)).to include(path)
        expect(subject.payload(verb, path, params)).to include(verb)
        expect(subject.payload(verb, path, params)).to include(params[:param])
      end
    end

    describe '#format_params' do
      let(:params) { { param: 'param' } }

      it 'merges the given params with the access key and a tonce in a hash' do
        expect(subject.format_params(params)).to include(:access_key)
        expect(subject.format_params(params)).to include(:tonce)
      end
    end
  end
end
