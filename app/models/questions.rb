# frozen_string_literal: true

# This is not intended as an active record model and could just as well be seen as a form
# It will have model logic so I placed it in the models, that does not mean that
# it should be made a DB model for the release
#
class Questions
  include ActiveModel::Model

  Symbols::QUESTIONS.keys.each do | question |
    define_method("#{question}") { @all_answers[question] }
    define_method("#{question}=") { | value | @all_answers[question] = value }
    #All questions must be present for the model to be valid.
    validates question.to_sym, presence: true
  end

  def initialize(params = nil)
    setup_attributes(params)
  end

  def self.find(_id)
    Questions.new
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

  def results(all_answerd_questions)
    [ :H1, :H3, :A1]
  end

  private

  def setup_attributes(params)
    @all_answers ||= HashWithIndifferentAccess.new(params)

  end
   

end
