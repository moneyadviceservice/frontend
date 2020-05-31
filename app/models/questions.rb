# frozen_string_literal: true

# This is not intended as an active record model and could just as well be seen as a form
# It will have model logic so I placed it in the models, that does not mean that
# it should be made a DB model for the release
#
#TODO: move all money helper code/test etc into its own namespace
class Questions
  include ActiveModel::Model
  include Symbols

  QUESTIONS.each do | qn |
    question = qn[:code].to_s.downcase
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

  #Provided with all answers to all the answered questions this method behaves as follows:
  #It iterates over the possible sections to determine which sections and headers and content are
  #to be displayed.
  #The return hash is an ordered array of section objects each containing an array of content objectse.g.
  #[
  #   { 
  #     section_code: S1,
  #     headings: [
  #      {
  #         heading_code: H1
  #         content: coronavirus-debt-advice-url
  #       }
  #     ]
  #   }
  #]
  # The caller should simply display the content.
  # For now the content is the CMS URL however that will change to the actual content 
  # from CMS once integration is achieved
  def results(all_answered_questions)
    #[ :H1, :H3, :A1]
    answers_flags = convert_to_flags(all_answered_questions)
    section_results = HashWithIndifferentAccess.new
    RESULTS.each do |section|
      res = {}
      res[:section_code] = section[:section_code]
      section[:headings].each do |heading|
        #TODO: Only include a heading in the results if it has one or more content children that match with all_answered_questions
        res[:headings] = {}

        heading[:content].each do | content |
          triggered = ''
          content[:triggers].each do | trigger |
            trigger_flags = convert_to_flags(trigger) 
            triggerd = "#{triggerd}#{trigger_flags & answers_flags == trigger_flags? 1 : 0}"
          end
          enable_content = triggered & content[:mask] == content[:mask]
          if enable_content
            res[:headings][:heading_code] = heading[:heading_code]
            res[:headings][:content] = heading[:article]
          end
        end
      end

      res >> section_results if !res[:headings].empty?
    end

    section_results
  end

  private

  #This method accepts a hash of questions and their answers. 
  #It output the standardised  flags representation 
  def convert_hash_to_flags(question_answers_hash)
    normalised_hash = normalise_answers_hash(question_answers_hash)
    flags = QUESTIONS.inject('') do | flag_str, qn |
      flag_str += qn[:flag]
      ans_flags = qn[:responses].inject(FLAGS[EMPTY.to_sym]) do |flags, resp|
        flags = flags | resp[:flag].to_i(2) if question_answers_hash[qn[:code]].contains?(resp[:code]) 
      end
      flag_str += ans_flags.to_s(2)
    end

    flags
  end 
  
  #This method accepts a flat array of questions and their answers
  #as used in the rules configuration (e.g. ['Q2_A1', 'Q4_A1', 'Q4_A2']) 
  #It returns
  #- a normalised question-answer hash
  def unflatten_answers_array(question_answers_array)
    qa_hash = HashWithIndifferentAccess.new  
    unflattened = question_answers_array.inject(HashWithIndifferentAccess.new) do |qa_hash, qa_str|
      key_val = qa_str.split('_', 2)
      qa_hash[key_val[0]] = [] if qa_hash[key_val[0]].nil?
      qa_hash[key_val[0]] << key_val[1]
      qa_hash
    end

    normalise_answers_hash(unflattened)
  end

  #This does the opposite of unflatten_answers_array
  #It accepts a hash as submitted by the form 
  #- normalises the hash
  #- converts it to a flat array
  #as used in the rules configuration (e.g. ['Q2_A1', 'Q4_A1', 'Q4_A2', 'Q4_A6']) 
  def flatten_answers_hash(answers_hash)
    answers_hash = normalise_answers_hash(answers_hash)    

    flattened = answers_hash.inject([]) do | arr, q_code, answers |
      answers.each {|answer| arr << "#{ q_code.to_s }_#{answer}"}
      arr
    end

    flattened
  end
    
  #Given a bunch of questions and their answers in the format received from the form
  #this method returns a Hash in which all known questions have an answers array.
  #- key values that are not an array are placed into an array of size=1
  #- Unanswered questions are given keys with an empty array value
  def normalise_answers_hash(answers_hash)
    #make sure all submitted answers are an array for uniform processing
    answers_hash.trasform_values!{|v| v.is_a?(Array) ? v : [v]}
    #fill in the missing questions using  empty answers arrays
    normalised_answers_hash = QUESTIONS.inject(HashWithIndifferentAccess.new)do |hash, q_hash|
      hash[q_hash[:code]] = answers_hash[q_hash[:code]].nil? [EMPTY] : answers_hash[q_hash[:code]]
      hash
    end

    normalised_answers_hash
  end

  def setup_attributes(params)
    @all_answers ||= HashWithIndifferentAccess.new(params)
  end

  def convert_answers_array_to_flags(answers_array)
    answers_hash = unflatten_answers_array(answers_array)
    flags_str = answers_hash.inject('') do | bit_str, q_code, answers |
      bit_str += QUESTIONS_HASH[q_code][:flag]
      QUESTIONS_HASH[q_code][:responses]
      bit_str += answers.inject(FLAGS[EMPTY]) do |flags, ans_str| 
        flags |= ANSWERS_HASH[ans_str][:flag]
        flags
      end

      bit_str
    end

    flags_str
end
