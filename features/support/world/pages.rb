module World
  module Pages
    def current_page
      UI::Page.new
    end

    pages = %w[
      account
      change_password
      debt_management
      debt_management_companies
      forgot_password
      internal_server_error
      profile
      sitemap
      settings
      sign_in
      sign_up
      static
      tools
    ]

    pages.each do |page|
      define_method("#{page}_page") do
        "UI::Pages::#{page.camelize}".constantize.new
      end
    end
  end
end

World(World::Pages)
