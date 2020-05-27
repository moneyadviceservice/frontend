class C19DiagnosticsController < ApplicationController

  def landing;end

  def questionnaire
    #If we are here with no questions to process then reset to begining of questionair
    clear_session if no_answers_submitted?

    @model = Questions.new(updated_questions(params[:questions]))

    if no_answers_submitted? || more_questions_to_display?
      @current_questions = @model.next_question
      render 'questionnaire'
    else
      @results = @model.results
      render 'results'
    end

  end
  
  def show;end

  def current_questions
    @current_questions
  end
  helper_method :current_question

  def updated_questions(questions)
    session[:all_questions] ||= HashWithIndifferentAccess.new
    session[:all_questions].merge!(questions) unless questions.nil?
  end

  def clear_session
    session[:all_questions] = nil
  end

  def no_answers_submitted?
    params[:questions].nil?
  end

  def more_questions_to_display?
   !@model.next_question.nil?
  end
end
