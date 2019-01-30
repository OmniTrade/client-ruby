# frozen_string_literal: true

require 'json'
require 'net/http'
require 'openssl'
require_relative 'client/version'

module OmniTradeAPI
  class Client
    attr_reader :auth

    def initialize(options = {})
      options = options.symbolize_keys
      setup_auth_keys options
      @endpoint = options[:endpoint] || 'https://omnitrade.io/'
      @timeout  = options[:timeout]  || 60
    end

    def get_public(path, params = {})
      uri = URI("#{@endpoint}#{path}")
      uri.query = URI.encode_www_form params

      request(:get, path, nil, params) do |http, _|
        http.request_get(uri.request_uri)
      end
    end

    def get(path, params = {})
      check_auth!

      uri = URI("#{@endpoint}#{path}")

      request(:get, path, @auth, params) do |http, signed_params|
        uri.query = URI.encode_www_form signed_params
        http.request_get(uri.request_uri)
      end
    end

    def post(path, params = {})
      check_auth!

      request(:post, path, @auth, params) do |http, signed_params|
        http.request_post(path, signed_params.to_query)
      end
    end

    private

    def request(action, path, auth, params = {})
      uri = URI("#{@endpoint}#{path}")
      params = auth.signed_params action.to_s.upcase, path, params if auth

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.open_timeout = @timeout
      http.use_ssl = true if @endpoint.start_with?('https://')

      http.start do |http|
        parse yield(http, params)
      end
    end

    def parse(response)
      if response.code == '200' || response.code == '201'
        JSON.parse(response.body)
      else
        raise_error(response)
      end
    end

    def setup_auth_keys(options)
      return unless options[:access_key] and options[:secret_key]

      @access_key = options[:access_key]
      @secret_key = options[:secret_key]
      @auth       = Auth.new @access_key, @secret_key
    end

    def check_auth!
      raise ArgumentError, 'Missing access key and/or secret key' if @auth.nil?
    end

    def raise_error(response)
      if response.body['error'].nil?
        code = response.code
        message = response.message
      else
        api_error = JSON.parse(response.body)['error']
        code = api_error['code']
        message = api_error['message']
      end
      raise Net::HTTPBadResponse, code, message
    end
  end
end
