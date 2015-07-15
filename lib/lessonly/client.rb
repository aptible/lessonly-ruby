require 'sawyer'
require 'lessonly/serializer'
require 'base64'

module Lessonly
  class Client
    include Lessonly::Defaults
    attr_reader :agent
    attr_reader :last_response

    def get(url, query = {})
      request :get, url, nil, query: query
    end

    def post(url, resource, query = {})
      request(:post, url, resource, query: query)
    end

    def put(url, resource, query = {})
      request :put, url, resource, query: query
    end

    def delete(url, resource)
      request :delete, url, resource
    end

    def patch(url, resource, query = {})
      request :patch, url, resource, query: query
    end

    def agent
      @agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
        http.headers[:accept] = media_type
        http.headers[:user_agent] = user_agent
        http.headers[:authorization] = "Basic #{auth_token}"
      end
    end

    private

    def auth_token
      Base64.strict_encode64("#{domain}:#{api_key}")
    end

    def sawyer_options
      {
        faraday: Faraday.new(connection_options),
        serializer: Lessonly::Serializer.any_json
      }
    end

    def request(method, path, data, options = {})
      options[:headers] ||= {}
      unless method == :get
        options[:headers][:content_type] = 'application/json'
      end

      @last_response = agent.call(method, path, data, options)
      @last_response.data
    end
  end
end
