require_relative '../page'
require_relative '../sections/footer_site_links'

module UI::Pages
  class ActionPlan < UI::Page
    set_url '{/locale}/action_plans{/id}'

    element :heading, 'h1'
    element :content, '#action-plan-content'

    section :footer_site_links, UI::Sections::FooterSiteLinks, '.footer-site-links'
  end
end
