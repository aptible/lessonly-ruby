module Lessonly
  class Exception < ::StandardError
    attr_accessor :cause

    def initialize(message, attrs = {})
      self.cause = attrs[:cause]
      super(message)
    end
  end

  class ResponseError < Exception
    attr_accessor :response
    attr_accessor :body

    def initialize(message, attrs = {})
      self.response = attrs[:response]
      self.body = attrs[:body]

      if body.present? && body.key?(:error)
        error = body[:error]
        message = "#{message} (#{error})"
      elsif response
        message = "#{message} (\"#{response.inspect}\")"
      end

      super(message, attrs)
    end
  end

  class ResourceNotFoundError < ResponseError; end
end
