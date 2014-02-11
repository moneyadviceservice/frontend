require 'active_resource'
require 'forwardable'

module Core
  module Repositories
    class ActiveResource
      extend Forwardable

      def initialize(url, type)
        self.url = url
        self.type = type
      end

      def find(id)
        Model.find(id, params: { locale: I18n.locale }).attributes
      rescue ::ActiveResource::ResourceNotFound
        nil
      end

      private

      Model              = Class.new(::ActiveResource::Base)
      Model.element_name = @type

      def_delegator Model, :site, :url
      def_delegator Model, :site=, :url=
      def_delegator Model, :element_name, :type
      def_delegator Model, :element_name=, :type=
    end
  end
end
