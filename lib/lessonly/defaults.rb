require 'lessonly/version'

module Lessonly
  module Defaults
    def api_key
      Lessonly.configuration.api_key
    end

    def api_endpoint
      Lessonly.configuration.root_url
    end

    def domain
      Lessonly.configuration.domain
    end

    def user_agent
      "Lessonly Ruby Gem #{Lessonly::VERSION} made by Aptible"
    end

    def media_type
      'application/json'
    end

    def connection_options
      {
        headers: {
          accept: media_type,
          user_agent: user_agent
        }
      }
    end
  end
end
