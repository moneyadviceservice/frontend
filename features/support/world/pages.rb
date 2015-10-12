module World
  module Pages
    def current_page
      UI::Page.new
    end

    pages = %w(
      account
      action_plan
      article
      article_feedback
      category
      corporate
      corporate_tool
      corporate_tool_directory
      forgot_password
      home
      news
      news_article
      partners
      profile
      quiz_admin
      search_results
      settings
      sign_in
      sign_up
      static
      technical_feedback
    )

    pages.each do |page|
      define_method("#{page}_page") do
        "UI::Pages::#{page.camelize}".constantize.new
      end
    end
  end
end

World(World::Pages)
