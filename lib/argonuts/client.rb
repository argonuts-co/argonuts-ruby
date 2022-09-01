module Argonuts
  def self.default_client
    Client.new({
                 api_key: Argonuts.api_key,
                 # region: Argonuts.region,
                 endpoint: Argonuts.endpoint
               })
  end

  class Client
    attr_accessor :api_key, :endpoint #, :region

    def initialize(options = {})
      @api_key = options[:api_key]
      # @region = options[:region]
      @endpoint = options[:endpoint]
    end

    def endpoint
      if @endpoint
        return @endpoint
      end

      # if @region
      #   return "https://argonuts.co/api-#{@region}/v1"
      # end

      return Argonuts::ENDPOINT
    end
  end
end
