require 'spec_helper'

module OmniTradeAPI
  describe StreamingClient do
    let(:websocket_url) { 'wss://omnitrade.io:8080' }

    describe '#run' do
      context 'outputs requests to logs' do
        let(:logger_dummy) { double("Logger").as_null_object }

        subject { described_class.new(logger: logger_dummy) }

        before(:example) do
          stub_request(:get, "#{websocket_url}")
            .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
            .to_return(status: 200, headers: {})
        end

        it 'outputs a connected message' do
          expect(logger_dummy).to receive(:info)

          subject.run
        end
      end
    end
  end
end
