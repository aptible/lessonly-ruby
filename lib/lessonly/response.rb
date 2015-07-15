require 'logger'
require 'lessonly/exceptions'
require 'pry'

module Sawyer
  class Response
    # rubocop:disable MethodLength
    def initialize(agent, res, options = {})
      if res.status >= 400
        fail Lessonly::ResponseError.new(
          res.status.to_s,
          response: res,
          body: agent.decode_body(res.body),
          cause: res.status
        )
      end

      @res = res
      @agent = agent
      @status = res.status
      @headers = res.headers
      @env = res.env
      @rels = process_rels
      @started = options[:sawyer_started]
      @ended = options[:sawyer_ended]
      @data = if @headers[:content_type] =~ /json|msgpack/
                process_data(@agent.decode_body(res.body))
              else
                res.body
              end
      log_response
    end
    # rubocop:enable MethodLength

    def log_response
      puts @env
    end

    def process_data(data)
      @type = type_from_data(data) || @type
      fail 'No type!' unless @type

      data = data[@type.to_sym] if data.key?(@type.to_sym)

      case data
      when Hash  then klass_from_type(data).new(agent, data)
      when Array then data.map { |hash| process_data(hash) }
      when nil   then nil
      else data
      end
    end

    def klass_from_type(result)
      # Get sub object type if exists, otherwise
      # defer to parent type
      type = type_from_data(result) || @type
      "Lessonly::#{type.classify}".constantize
    end

    def type_from_data(data)
      # Create user type: `create_user`
      # Delete user type: `delete_user`
      # Course assignment type: `course_assignments`
      # Use the last segment of type to determine resource class
      return nil unless data.key? :type
      data[:type].split('_').last
    end
  end
end
