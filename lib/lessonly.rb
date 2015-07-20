require 'gem_config'
require 'lessonly/defaults'

module Lessonly
  include GemConfig::Base

  with_configuration do
    has :root_url,
        classes: String,
        default: ENV['LESSONLY_ROOT_URL'] || 'https://api.lesson.ly/api/v1'

    has :api_key,
        classes: String,
        default: ENV['LESSONLY_API_KEY'] || ''

    has :domain,
        classes: String,
        default: ENV['LESSONLY_DOMAIN'] || ''
  end
end

require 'lessonly/client'
require 'lessonly/resource'
