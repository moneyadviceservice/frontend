class MoneyNavigatorToolController < EmbeddedToolsController
  include Localisation

  # Code and helpers required by the syndication layout
  #########################################
  # These would usually be provided by the engine mounting framework but this
  # tool is not an engine. If it inherits from the MountController then it falls foul
  # of other tool mounting assumptions. These methods are the equivalent of methods
  # in the MountController that are required to use the `engine_*` layouts dynamically
  # used within the parent ApplicationController which in turn
  # provide javascript to resize the tool iframe appropriately when it is syndicated.
  #
  #########################################
  def alternate_options
    I18n.translate('money_navigator_tool.meta.alternate')
  end
  helper_method :alternate_options

  def alternate_locale
    { en: :cy, cy: :en }.fetch(I18n.locale)
  end
  helper_method :alternate_locale

  def alternate_url
    alternate_options["#{alternate_locale}-GB"]
  end
  helper_method :alternate_url

  def exclude_syndicated_iframe_resizer?
    false
  end
  helper_method :exclude_syndicated_iframe_resizer?

  def breadcrumbs
    BreadcrumbTrail.home
  end
  helper_method :breadcrumbs

  def engine_content?
    false
  end

  def engine_name
    'money_navigator_tool'
  end

  def alternate_tool_id
    @alternate_tool_id ||= if alternate_locale == :en
                             ToolMountPoint::MoneyNavigatorTool::EN_ID
                           else
                             ToolMountPoint::MoneyNavigatorTool::CY_ID
                           end
  end

  def check_syndicated_layout
    'engine_syndicated' if syndicated_tool_request?
  end

  #########################################

  def landing; end

  def questionnaire
    if no_answers_submitted?
      clear_session
      @model = MoneyNavigator::Questions.new
    else
      @model = MoneyNavigator::Questions.new(updated_questions(submitted_answers))
      redirect_to action: 'results' if @model.valid?
    end
  end

  def results
    # Get the valid answers from the session and run them
    # through the model to obtain the results to display
    @model = MoneyNavigator::Questions.new(updated_questions(nil))
    @results = @model.results
  end

  private

  def updated_questions(questions)
    session[:all_questions] = HashWithIndifferentAccess.new if session[:all_questions].nil?
    session[:all_questions].merge!(questions) unless questions.nil?
    session[:all_questions]
  end

  def clear_session
    session[:all_questions] = nil
  end

  def no_answers_submitted?
    params[:money_navigator_questions].nil?
  end

  def submitted_answers
    params[:money_navigator_questions]
  end
end
