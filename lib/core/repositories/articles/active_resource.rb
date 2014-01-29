require 'active_resource'
require 'forwardable'

module Core
  module Repositories
    module Articles
      class ActiveResource
        extend Forwardable

        def initialize(url)
          self.url = url
        end

        def find(id)
          Model.find(id, params: { locale: I18n.locale }).attributes
        rescue ::ActiveResource::ResourceNotFound
          nil
        end

        private

        Model              = Class.new(::ActiveResource::Base)
        Model.element_name = 'article'

        def_delegator Model, :site, :url
        def_delegator Model, :site=, :url=
      end
    end
  end
end
