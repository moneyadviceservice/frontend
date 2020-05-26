# frozen_string_literal: true

# This is not intended as an active record model and could just as well be seen as a form
# It will have model logic so I placed it in the models, that does not mean that
# it should be made a DB model for the release
#
#This model can be used in two ways
# 1. You ask for the next question to display. 
#     Input: current question code  and code of answer provided OR nill for the first question
#     Output: Code of next question to display
# 2. You ask for the headings (content) to display at the end of the questionaire. 
#     Input: Codes for all the questions and thier answers provided
#     Output: Codes for all the headings and flags that resulted
class Question
  include ActiveModel::Model

  attr_accessor :sample_question

  validates :sample_question, inclusion: { in: [true, false] }

  def self.find(_id)
    Question.new
  end

  def destroy
    true
  end

  def update
    true
  end

  def save
    true
  end
end
