module Lessonly
  class Serializer < Sawyer::Serializer
    def encode_object(resource)
      resource
      # return resource.serialize if resource.respond_to? :serialize
      # case resource
      # when Hash then encode_hash(resource)
      # when Array then resource.map { |o| encode_object(o) }
      # else resource
      # end
    end

    def time_field?(key, value)
      time_fields = %w(created updated start stop initalPeriodStart
                       currentPeriodStart currentPeriodEnd)
      value && time_fields.include?(key)
    end
  end
end
