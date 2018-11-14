# OmniTrade API Ruby Client

[![Build Status](https://travis-ci.com/OmniTrade/client-ruby.svg?branch=master)](https://travis-ci.com/OmniTrade/client-ruby)

**omnitrade_client** is an open-source Ruby gem that integrates the **[OmniTrade](https://omnitrade.io/)** API.

You can read the API documentation by visiting **<https://omnitrade.io/documents/api_v2>**

## Installation

Add `omnitrade_client` to your `Gemfile`.

```ruby
gem 'omnitrade_client', github: 'OmniTrade/client-ruby'
```

Install by running:

```
bundle install
```

## Usage

Require the client in your code by adding:

```ruby
require 'omnitrade_client'
```

You can use both the public or private API.

### Public
------
Instance your public client by using:

```ruby
public_client = OmniTradeAPI::Client.new
```

#### .get_public

Use **`.get_public`** to make a GET request to an URL, as the following example:

```ruby
client_public.get_public '/api/v2/markets'
```

### Private
------

When using the private client, you also have to specify your access and private keys in the instantiation:

```ruby
private_client = OmniTradeAPI::Client.new access_key: 'your_access_key', secret_key: 'your_secret_key'
```

You can also set a timeout and/or endpoit by adding the arguments:

```ruby
private_client = OmniTradeAPI::Client.new access_key: 'your_access_key', secret_key: 'your_secret_key', timeout: 60, endpoint: 'https://omnitrade.io/'
```
#### .get

Use **`.get`** to make a GET request to an URL, you can also set the required arguments, as the following example:

```ruby
private_client.get '/api/v2/orders', market: 'btcbrl'
```

#### .post

Use **`.post`** to make a POST request to an URL, you can also set the required arguments, as the following example:

```ruby
private_client.post '/api/v2/order', market: 'btcbrl', side: 'buy', volume: '0.42', price: '4200.0'
```

## WebSocket API

You can also make use of the **[OmniTrade WebSocket API](https://omnitrade.io/documents/websocket_api)**:

```ruby
require 'omnitrade_client'

streaming_client = OmniTradeAPI::StreamingClient.new access_key: 'your_access_key', secret_key: 'your_secret_key'
```

## Usage

```ruby
  streaming_client = OmniTradeAPI::StreamingClient.new access_key: 'your_access_key', secret_key: 'your_secret_key'

  client.run do |message|
    # use the message as desired
  end
```

## Licence

OmniTrade (C) All Rights Reserved.

`omnitrade_client` is released under Apache License 2.0.
