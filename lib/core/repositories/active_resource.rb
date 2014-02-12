require 'active_resource'
require 'forwardable'

module Core
  module Repositories
    class ActiveResource
      extend Forwardable

      def initialize(url, type)
        self.model = Class.new(::ActiveResource::Base)
        self.url   = url
        self.type  = type
      end

      def find(id)
        model.find(id, params: { locale: I18n.locale }).attributes
      rescue ::ActiveResource::ResourceNotFound
        nil
      end

      private

      attr_accessor :model

      def_delegator :model, :site, :url
      def_delegator :model, :site=, :url=
      def_delegator :model, :element_name, :type
      def_delegator :model, :element_name=, :type=
    end
  end
end
