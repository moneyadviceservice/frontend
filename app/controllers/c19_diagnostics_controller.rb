class C19DiagnosticsController < ApplicationController

  def landing;end
  
  def questionnaire
    @model = Questions.new(updated_questions(params[:questions]))
    @current_questions = @model.next_question

    if !params[:questions].nil?
      if !@model.valid? 
        flash.now[:error] = t('c19_diagnostics_tool.messages.form_error')
        render 'questionnaire'
      else
        if @current_questions.nil? 
          render 'results'  
        else
          render 'questionnaire'
        end
      end
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
end
