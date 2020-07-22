class MoneyNavigatorToolController < ApplicationController
  include Localisation

  #Code and helpers required by the syndication layout
  #########################################
  #These would usually be provided by the engine mounting framework but this
  #tool is not an engine. If it inherits from the MountController then it falls foul
  #of other tool mounting assumptions. These methods are the equivalent of methods
  #in the MountController that are required to use the `engine_*` layouts dynamically 
  #used within the parent ApplicationController which in turn
  #provide javascript to resize the tool iframe appropriately when it is syndicated.
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
  #########################################

  def landing;end

  def questionnaire
    if no_answers_submitted?
      clear_session
      @model = Questions.new
    else
      @model = Questions.new(updated_questions(submitted_answers))
      redirect_to action:  'results' if @model.valid?
    end
  end

  def results
    #Get the valid answers from the session and run them
    #through the model to obtain the results to display
    @model = Questions.new(updated_questions(nil))
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
    params[:questions].nil?
  end

  def submitted_answers
    params[:questions]
  end

  #TODO: Don't think this is needed. remove at final cleanup
  def errors_for(question)
    content_tag(:p, @model.errors[question].try(:first), class: 'help-block')
  end
  helper_method :errors_for
end
