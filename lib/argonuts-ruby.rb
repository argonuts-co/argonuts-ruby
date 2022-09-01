require "argonuts/api"
require "argonuts/error"
require "argonuts/client"
require "argonuts/job"
require "argonuts/metadata"
require "argonuts/version"

module Argonuts
  ENDPOINT = "https://argonuts.co/api/v1"

  def self.api_key=(key)
    @api_key = key
  end

  def self.api_key
    @api_key
  end

  def self.region=(region)
    @region = region
  end

  def self.region
    @region
  end

  def self.endpoint=(endpoint)
    @endpoint = endpoint
  end

  def self.endpoint
    @endpoint
  end

  def self.notification=(notification)
    @notification = notification
  end

  def self.notification
    @notification
  end

  def self.storage=(storage)
    @storage = storage
  end

  def self.storage
    @storage
  end
end
