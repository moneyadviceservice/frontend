# frozen_string_literal: true

# This is not intended as an active record model and could just as well be seen as a form
# It will have model logic so I placed it in the models, that does not mean that
# it should be made a DB model for the release
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
