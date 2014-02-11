require 'active_resource'
require 'forwardable'

module Core
  module Repositories
    class ActiveResource
      extend Forwardable

      def initialize(url, model_name)
        self.url = url
        @model_name = model_name
      end

      def find(id)
        Model.find(id, params: { locale: I18n.locale }).attributes
      rescue ::ActiveResource::ResourceNotFound
        nil
      end

      private

      Model              = Class.new(::ActiveResource::Base)
      Model.element_name = @model_name

      def_delegator Model, :site, :url
      def_delegator Model, :site=, :url=
    end
  end
end
