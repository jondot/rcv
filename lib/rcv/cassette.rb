require 'yaml'
require 'rest-client'
require 'diffy'

module RCV
  module HeaderDowncaser
    def self.downcase_headers(headers)
      {}.tap do |downcased|
        headers.each do |k, v|
          downcased[k.downcase] = v
        end
      end
    end
  end

  class Cassette
    def initialize(cassette_file)
      @loaded_cassette = ::YAML.load_file(cassette_file)
    end

    def reverse_play
      @loaded_cassette['http_interactions'].map do |http_interaction|
        reverse_play_interaction(http_interaction)
      end
    end

    def reverse_play_interaction(interaction)
      request = interaction["request"]
      response = interaction["response"]

      req = {
        method: request["method"].to_sym,
        url: request["uri"]
      }
      req[:payload] = request["body"]["string"] if has_data?(request)
      req[:headers] = request["headers"] if has_headers?(request)

      # normalize vcr headers as well
      res = RestClient::Request.execute(req)
      vcr_response = {
         status: response["status"]["code"],
         headers: HeaderDowncaser.downcase_headers(response["headers"]),
         body: response["body"]["string"]
      }
      backend_response = {
        status: res.code,
        headers: slice(HeaderDowncaser.downcase_headers(res.raw_headers), *vcr_response[:headers].keys),
        body: res.to_str
      }
      [req, backend_response, vcr_response]
    end

  private
    def slice(source, *keys)
      keys.map! { |key| source.convert_key(key) } if source.respond_to?(:convert_key, true)
      keys.each_with_object(source.class.new) { |k, hash| hash[k] = source[k] if source.has_key?(k) }
    end

    def has_data?(request)
      request["body"]["string"].length > 0
    end

    def has_headers?(request)
      request["headers"].keys.size > 0
    end
  end
end
