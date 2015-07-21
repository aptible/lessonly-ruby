require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'lessonly/response'

module Lessonly
  class Resource < Sawyer::Resource
    def self.all(query = {})
      client.get collection_path, query: query
    end

    def self.find(id)
      find_by_href("#{collection_path}/#{id}")
    end

    def self.find_by_href(href)
      client.get(href)
    end

    def self.create(params, query = {})
      client.post collection_path, new(client.agent, params), query: query
    end

    def self.collection_path
      basename
    end

    # rubocop:disable PredicateName
    def self.has_many(relation)
      define_has_many_getter(relation)
      # TODO: define_has_many_setter(relation)
    end
    # rubocop:enable PredicateName

    def self.define_has_many_getter(relation)
      define_method relation do
        if (memoized = instance_variable_get("@#{relation}"))
          memoized
        else
          entries = client.get("#{href}/#{relation}")
          instance_variable_set("@#{relation}", entries)
          entries
        end
      end
    end

    # rubocop:disable PredicateName
    def self.has_one(relation, options = {})
      define_method relation do
        if (memoized = instance_variable_get("@#{relation}"))
          memoized
        else
          klass = options[:klass] || "Lessonly::#{relation.classify}"

          id_attr = options[:using] ? options[:using] : "#{relation}_id"
          relation_id = instance_variable_get('@attrs')[id_attr]

          if relation_id
            item = klass.constantize.find(relation_id)
            instance_variable_set("@#{relation}", item)
          end
        end
      end
    end
    # rubocop:enable PredicateName

    def self.basename
      name.split('::').last.underscore.dasherize.pluralize
    end

    def update(params)
      self.attrs = attrs.merge(params)
      client.put href, self
    end

    def destroy
      client.delete href, self
    end

    def reload
      self.class.find_by_href(href)
    end

    def href
      "#{self.class.collection_path}/#{id}"
    end

    def self.client
      @client ||= Lessonly::Client.new
    end

    def client
      self.class.client
    end
  end
end

require 'lessonly/resource/assignment'
require 'lessonly/resource/course'
require 'lessonly/resource/group'
require 'lessonly/resource/lesson'
require 'lessonly/resource/user'
