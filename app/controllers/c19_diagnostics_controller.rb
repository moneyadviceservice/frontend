class C19DiagnosticsController < ApplicationController

  def landing;end

  def questionnaire
    #If we are here with no questions to process then reset to begining of questionair
    clear_session if no_answers_submitted?

    @model = Questions.new

    if no_answers_submitted? 
      render 'questionnaire'
    else
      @results = @model.results(updated_questions(nil))
      render 'results'
    end

  end
  
  def show;end


  def updated_questions(questions)
    session[:all_questions] ||= HashWithIndifferentAccess.new
    session[:all_questions].merge!(questions) unless questions.nil?
    session[:all_questions]
  end

  def clear_session
    session[:all_questions] = nil
  end

  def no_answers_submitted?
    params[:questions].nil?
  end

  def errors_for(question)
    content_tag(:p, @model.errors[question].try(:first), class: 'help-block')
  end
  helper_method :errors_for
end
