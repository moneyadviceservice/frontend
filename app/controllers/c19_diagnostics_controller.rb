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
    @model = Questions.new
    @results = @model.results(updated_questions(nil))
  end


  #TODO: consider removing. Don't think we'll be needing the session storage
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

  def errors_for(question)
    content_tag(:p, @model.errors[question].try(:first), class: 'help-block')
  end
  helper_method :errors_for
end
