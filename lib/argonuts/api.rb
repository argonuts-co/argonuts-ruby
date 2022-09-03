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
      }
    end

    def self.request(verb, path, options = {})
      cli = options[:client] || Argonuts.default_client

      url = URI("#{cli.endpoint}#{path}")
      http = Net::HTTP.new(url.host, url.port)

      case verb
      when :get
        request = Net::HTTP::Get.new(url, 'Content-Type' => 'application/json')
      when :post
        request = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
        request.body = options[:json].to_json
      end

      headers(cli).map { |k, v| request[k] = v }
      resp = http.request(request)

      if resp.code.to_i > 399
        # if response is 400 or 401, we return the error message and error code
        raise Argonuts::Error, "Server returned HTTP status #{resp.code}."
      end

      return JSON::parse(resp.body)
    end
  end
end
