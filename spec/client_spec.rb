require 'spec_helper'

module OmniTradeAPI 
  describe Client do
    let(:omnitrade_url) { 'https://omnitrade.io' }

    describe '#get_public' do
      let(:public_client) { described_class.new }
      let(:markets_path) { '/api/v2/markets' }
      let(:markets) { [{"id"=>"btcbrl", "name"=>"BTC/BRL"}, {"id"=>"ltcbtc", "name"=>"LTC/BTC"}] }

      context 'with valid request' do
        before(:example) do
          stub_request(:get, "#{omnitrade_url}/#{markets_path}")
            .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
            .to_return(status: 200, body: markets.to_json, headers: {})
        end

        it 'makes a valid request' do
          expect(public_client.get_public markets_path).to_not include(:http_error)
        end

        it 'returns the markets' do
          expect(public_client.get_public markets_path).to eq(markets)
        end
      end

      context 'with invalid request' do
        before(:example) do
          stub_request(:get, "#{omnitrade_url}/#{markets_path}")
            .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
            .to_return(status: 404, body: "invalid request", headers: {})
        end

        it 'returns a http_error' do
          expect(public_client.get_public markets_path).to include(:http_error)
        end
      end
    end

    describe '#get' do
      let(:private_client) { described_class.new access_key: access_key, secret_key: secret_key }
      let(:access_key) { '123456' }
      let(:secret_key) { '123456' }
      let(:orders_path) { '/api/v2/orders' }
      let(:signature) { 'd0b413205a962ffb6dcba32d91367dfe5c10c7e8cba990b1621aeb178668707d' }
      let(:orders) {
        [{"id"=>42,"side"=>"sell","ord_type"=>"limit","price"=>"10.0","avg_price"=>"0.0",
        "state"=>"wait","market"=>"btcbrl","created_at"=>"2018-04-05T13=>34=>57-03=>00",
        "volume"=>"1.0","remaining_volume"=>"1.0","executed_volume"=>"0.0","trades_count"=>0},
        {"id"=>43,"side"=>"sell","ord_type"=>"limit","price"=>"10.0","avg_price"=>"0.0",
        "state"=>"wait","market"=>"btcbrl","created_at"=>"2018-04-05T13=>37=>57-03=>00",
        "volume"=>"1.0","remaining_volume"=>"1.0","executed_volume"=>"0.0","trades_count"=>0}]
      }

      let(:attributes) do
        {
          market: 'btcbrl',
          price: '10',
          side: 'buy',
          tonce: 123,
          volume: 1
        }
      end

      let(:data) { "?access_key=#{access_key}&market=btcbrl&price=10&side=buy&signature=#{signature}&tonce=123&volume=1" }

      context 'with valid orders request' do
        before(:example) do
          stub_request(:get, "#{omnitrade_url}/#{orders_path}#{data}")
            .with(headers: { 'Accept' => '*/*', 'User-Agent'=>'Ruby' })
            .to_return(status: 200, body: orders.to_json, headers: {})
        end

        it 'makes a valid request' do
          expect(private_client.get orders_path, attributes).to_not include(:http_error)
        end

        it 'returns the orders' do
          expect(private_client.get orders_path, attributes).to eq(orders)
        end
      end

      context 'with invalid request' do
        before(:example) do
          stub_request(:get, "#{omnitrade_url}/#{orders_path}#{data}")
            .with(headers: { 'Accept' => '*/*', 'User-Agent'=>'Ruby' })
            .to_return(status: 404, body: 'invalid request', headers: {})
        end

        it 'returns a http_error' do
          expect(private_client.get orders_path, attributes).to include(:http_error)
        end
      end
    end

    describe '#post' do
      let(:private_client) { described_class.new access_key: access_key, secret_key: secret_key }
      let(:orders_path) { '/api/v2/orders' }
      let(:access_key) { '123456' }
      let(:secret_key) { '123456' }   
      let(:order) {
        {"id"=>42,"side"=>"sell","ord_type"=>"limit","price"=>"10.0","avg_price"=>"0.0",
        "state"=>"wait","market"=>"btcbrl","created_at"=>"2018-04-05T13=>34=>57-03=>00",
        "volume"=>"1.0","remaining_volume"=>"1.0","executed_volume"=>"0.0","trades_count"=>0}
      }

      let(:attributes) do
        {
          market: 'btcbrl',
          price: '10',
          side: 'buy',
          tonce: 123,
          volume: 1
        }
      end

      context 'with a valid orders post' do
        before(:example) do
          stub_request(:post, "#{omnitrade_url}#{orders_path}")
            .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
            .to_return(status: 200, body: order.to_json, headers: {})
        end

        it 'makes a valid post' do
          expect(private_client.post orders_path, attributes).to_not include(:http_error)
        end

        it 'returns the posted orders' do
          expect(private_client.post orders_path, attributes).to eq(order)
        end
      end

      context 'with invalid request' do
        before(:example) do
          stub_request(:post, "#{omnitrade_url}#{orders_path}")
            .with(headers: { 'Accept' => '*/*', 'User-Agent'=>'Ruby' })
            .to_return(status: 404, body: 'invalid request', headers: {})
        end

        it 'returns a http_error' do
          expect(private_client.post orders_path, attributes).to include(:http_error)
        end
      end
    end
  end
end
