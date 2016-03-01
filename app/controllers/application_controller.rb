class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success

  layout :check_syndicated_layout

  before_action :set_syndicated_x_frame

  include Authentication
  include Chat
  include Localisation

  helper  StickyNewsletterVisibility
  helper  ChatMigrationMessage
  helper  BudgetWarning

  COOKIE_MESSAGE_COOKIE_NAME  = '_cookie_notice'
  COOKIE_MESSAGE_COOKIE_VALUE = 'y'

  COOKIE_DISMISS_NEWSLETTER_NAME  = '_cookie_dismiss_newsletter'
  COOKIE_SUBMIT_NEWSLETTER_NAME   = '_cookie_submit_newsletter'
  COOKIE_HIDE_NEWSLETTER_VALUE    = 'hide'

  def syndicated_tool_request?
    !!request.headers['X-Syndicated-Tool']
  end

  helper_method :syndicated_tool_request?

  def parent_template
    if syndicated_tool_request?
      'layouts/engine_syndicated'
    else
      'layouts/engine'
    end
  end

  helper_method :parent_template

  def not_found
    fail ActionController::RoutingError.new('Not Found')
  end

  def cookies_not_accepted?
    cookies.permanent[COOKIE_MESSAGE_COOKIE_NAME] != COOKIE_MESSAGE_COOKIE_VALUE
  end

  helper_method :cookies_not_accepted?

  def display_sticky_newsletter_form_cookie?
    cookie_jar = []
    cookie_jar << cookies.permanent[COOKIE_DISMISS_NEWSLETTER_NAME]
    cookie_jar << cookies[COOKIE_SUBMIT_NEWSLETTER_NAME]

    !cookie_jar.include?(COOKIE_HIDE_NEWSLETTER_VALUE)
  end

  helper_method :display_sticky_newsletter_form_cookie?

  def newsletter_submitted_cookie_set?
    cookie_jar = []
    cookie_jar << cookies[COOKIE_SUBMIT_NEWSLETTER_NAME]

    cookie_jar.include?(COOKIE_HIDE_NEWSLETTER_VALUE)
  end

  helper_method :newsletter_submitted_cookie_set?

  def display_search_box_in_header?
    true
  end

  helper_method :display_search_box_in_header?

  def display_menu_button_in_header?
    true
  end

  helper_method :display_menu_button_in_header?

  def contact_panels_border_top?
    false
  end

  helper_method :contact_panels_border_top?

  def contact_panels_homepage?
    false
  end

  helper_method :contact_panels_homepage?

  def display_skip_to_main_navigation?
    true
  end

  helper_method :display_skip_to_main_navigation?

  def alerts?
    flash.keys.any?
  end

  helper_method :alerts?

  def set_tool_instance
  end

  private

  def set_syndicated_x_frame
    response.headers['X-Frame-Options'] = 'ALLOWALL' if syndicated_tool_request?
  end

  # This layout chops off the header and footer
  # It is used when the login/registration are presented in an iframe
  # e.g. https://partner-tools.moneyadviceservice.org.uk/en/users/sign_in
  # For when tools/engines need users to authenticate as part of their flow
  # This is vulnerable to clickjacking attacks
  def check_syndicated_layout
    'syndicated' if syndicated_tool_request?
  end

  def category_tree(categories = Core::Registry::Repository[:category].all)
    Core::CategoryTreeReader.new.call(categories)
  end

  def category_tree_with_decorator(categories = Core::Registry::Repository[:category].all)
    Core::CategoryTreeReaderWithDecorator.new.call(categories)
  end

  def navigation_categories
    Core::Registry::Repository[:category].all
  end

  def corporate_categories
    Core::Registry::Repository[:category].find('corporate-categories')['contents']
  end

  def corporate_category?(category, corporate = corporate_categories, categories = [])
    categories << corporate.map {|c| c['id']}
    return true if categories.flatten.include?(category)
    unless corporate.first['contents']
      corporate_category?(category, corporate.first['contents'], categories.flatten)
    end
  end

  helper_method :corporate_category?

  def category_navigation(corporate = false)
    categories = corporate ? corporate_categories : navigation_categories
    @category_navigation ||= CategoryNavigationDecorator.decorate_collection(category_tree_with_decorator(categories).children)
  end
  helper_method :category_navigation

  def corporate_category_navigation
    @corporate_category_navigation ||= CategoryNavigationDecorator.decorate_collection(category_tree_with_decorator(corporate_categories).children)
  end
  helper_method :corporate_category_navigation

  def hide_elements_irrelevant_for_third_parties?
    false
  end

  helper_method :hide_elements_irrelevant_for_third_parties?

  def hide_contact_panels?
    false
  end

  helper_method :hide_contact_panels?
end
