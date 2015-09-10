module Lessonly
  class Serializer < Sawyer::Serializer
    def encode_object(resource)
      return resource.serialize if resource.respond_to? :serialize
      resource
    end

    def time_field?(key, value)
      time_fields = %w(created updated start stop initalPeriodStart
                       currentPeriodStart currentPeriodEnd)
      value && time_fields.include?(key)
    end
  end
end
