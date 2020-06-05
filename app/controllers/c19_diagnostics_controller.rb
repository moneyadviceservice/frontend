class C19DiagnosticsController < ApplicationController

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
    @model = Questions.new()
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
