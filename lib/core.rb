require 'registry'

module Core
  module Connection
    autoload :Http, 'core/connection/http'
    autoload :Smtp, 'core/connection/smtp'
  end

  module ConnectionFactory
    autoload :Http, 'core/connection_factory/http'
    autoload :Smtp, 'core/connection_factory/smtp'
  end

  autoload :Entity, 'core/entity'
  autoload :Other, 'core/entity/other'
  autoload :StaticPage, 'core/entity/static_page'
  autoload :Customer, 'core/entity/customer'

  autoload :BaseContentReader, 'core/interactor/base_content_reader'

  module Interactors
    module Customer
      autoload :Finder, 'core/interactor/customer/finder'
      autoload :Creator, 'core/interactor/customer/creator'
      autoload :Updater, 'core/interactor/customer/updater'
    end

    autoload :UserUpdater, 'core/interactor/user_updater'
  end

  module Registry
    autoload :Connection, 'core/registry/connection'
    autoload :Repository, 'core/registry/repository'
  end

  module Repository
    autoload :Base, 'core/repository/base'
    autoload :Cache, 'core/repository/cache'
    autoload :VCR, 'core/repository/vcr'

    module Feedback
      autoload :Email, 'core/repository/feedback/email'
    end

    module Customers
      autoload :Fake, 'core/repository/customers/fake'
      autoload :Cream, 'core/repository/customers/cream'
    end

    module RecommendedTools
      autoload :Static, 'core/repository/recommended_tools/static'
    end

    module SavedTools
      autoload :Static, 'core/repository/saved_tools/static'
    end

    module Users
      autoload :Default, 'core/repository/users/default'
    end
  end
end
