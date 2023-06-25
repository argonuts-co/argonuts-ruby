require "net/http"
require "base64"
require "json"

module Argonuts
  # Argonuts::API is responsible for making API requests.
  # It takes a Argonuts::Client to send api_key, endpoint and region.
  class API
    def self.headers(cli)
      if cli.api_key.nil?
        raise Argonuts::Error, "You must specify an API key with Argonuts.api_key="
      end

      {
        'X-Auth-Token': cli.api_key,
        'User-Agent': "Argonuts/#{Argonuts::VERSION}",
        'Content-Type': 'application/json',
      }
    end

    def self.request(verb, path, options = {})
      require 'rest-client'

      cli = options[:client] || Argonuts.default_client

      begin
        case verb
        when :get
          resp = RestClient::Request.execute(
            method: :get,
            url: "#{cli.endpoint}#{path}",
            headers: {}.merge(self.headers(cli))
          )
        when :post
          headers = {}

          if options[:json][:input][:file]
            options[:json][:input][:file] = File.open(options[:json][:input][:file], 'rb')
          end

          resp = RestClient::Request.execute(
            method: :post,
            url: "#{cli.endpoint}#{path}",
            payload: options[:json],
            headers: headers.merge(self.headers(cli))
          )
        end
      rescue RestClient::ExceptionWithResponse => e
        if e.response.code.to_i > 399
          # if response is 400 or 401, we return the error message and error code
          raise Argonuts::Error, "Server returned HTTP status #{e.response.code.to_i}."
        end
      end

      return JSON::parse(resp.body)
    end
  end
end
