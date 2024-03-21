module World
  module Pages
    def current_page
      UI::Page.new
    end

    pages = %w[
      account
      article
      article_feedback
      category
      change_password
      corporate
      corporate_categories
      corporate_tool
      corporate_tool_directory
      debt_management
      debt_management_companies
      forgot_password
      home
      internal_server_error
      news
      news_article
      partners
      profile
      quiz_admin
      rio
      search_results
      sitemap
      settings
      sign_in
      sign_up
      static
      technical_feedback
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
