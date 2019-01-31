# frozen_string_literal: true

require 'spec_helper'

module OmniTradeAPI
  describe Config do
    describe '.get_omnitraderc' do
      let(:path) { 'spec/fixtures/config.file' }
      let(:secret_key) { 'accesskey123456' }
      let(:access_key) { 'secretkey654321' }

      it 'reads and strips the first two lines from a file' do
        expect(described_class.get_omnitraderc(path)).to include(secret_key)
        expect(described_class.get_omnitraderc(path)).to include(access_key)
      end
    end
  end
end
