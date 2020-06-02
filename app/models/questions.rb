# frozen_string_literal: true

# This is not intended as an active record model and could just as well be seen as a form
# It will have model logic so I placed it in the models, that does not mean that
# it should be made a DB model for the release
#
#TODO: move all money helper code/test etc into its own namespace
class Questions
  include ActiveModel::Model
  include Symbols

  #Dynamically setup the validateable instance fields that will be populated
  #when the model isinitialised and can be validated after initialisation
  QUESTIONS.each do | qn |
    question = qn[:code].to_s.downcase
    define_method("#{question}") { @submitted_answers[question] }
    define_method("#{question}=") { | value | @submitted_answers[question] = value }
    #All questions must be present for the model to be valid.
    validates question.to_sym, presence: true
  end

  def initialize(params = nil)
    @submitted_answers ||= HashWithIndifferentAccess.new(params)
  end

  #TODO: Clean all this stuff up later
  #########################################
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
  #########################################

  #Provided with all answers to all the answered questions this method behaves as follows:
  #It iterates over the content rules  to determine which sections, headers and content are
  #to be displayed.
  #The method returns an array of section objects each containing an array of headings containing an array of content as below
  #[
  #   {
  #     section_code: S1,
  #     headings: [
  #      {
  #         heading_code: H1
  #         content: [ coronavirus-debt-advice-url ]
  #       }
  #     ]
  #   }
  #]
  #The array is sorted by the section_code and the internal headings array is sorted by the headings_code
  #the content under the headings apears in the order in which it appears in CONTENT_RULES.
  #
  #NB.
  # - The caller should simply display the values of heading[:content] one after another.
  # - no section entry will be returned for sections with no content to display
  #
  # For now the content is the CMS URL however that will change to the actual content
  # from CMS once integration is achieved
  def results(all_answered_questions)
    #[ :H1, :H3, :A1]

    answers_flags = convert_hash_to_flags(all_answered_questions)
    
    sections_array =  CONTENT_RULES.inject([]) do |sections_array_accumulator, section_rules|

      heading_content_array = section_rules[:heading_rules].inject([]) do |content_array, heading_rule|
        content_array << obtain_content_for_heading(heading_rule, answers_flags)
        content_array
      end

      if !heading_content_array.empty?
        section_hash = HashWithIndifferentAccess.new
        section_hash[:section_code] = section_rules[:section_code]
        section_hash[:headings] = heading_content_array.sort {|h1, h2| /\d*$/.match(h1[:heading_code])[0].to_i <=> /\d*$/.match(h2[:heading_code])[0].to_i}
        sections_array_accumulator << section_hash
      end

      sections_array_accumulator
    end

    sections_array.sort {|s1, s2| /\d*$/.match(s1[section_code])[0].to_i <=> /\d*$/.match(s2[section_code])[0].to_i}
  end

  private


  #Method returns a hash representation of this Questions instance
  #TODO: This method sits between the instance members and the model. Consider writing tests for it
  def to_hash
    answers_hash = QUESTIONS.inject(HashWithIndifferentAccess.new) do |accumulator_hash, question|
      accumulator_hash[question[:code]] = send("#{ question[:code] }")
      accumulator_hash
    end

    normalise_answers_hash(answers_hash)
  end

  #Given a bunch of questions and their answers in the same hash format as submitted by the form 
  #this method returns a Hash in which 
  #1- nil key values become an [EMPTY] array (e.g. { q1: nil } becomes { q1: [EMPTY ]} ) 
  #2- non-nil key values that are not an array are placed into an array of size=1 (e.g. { q1: a1 } becomes { q1:[a1 ])}
  #3- Array key values are trimmed of any nils (e.g. { q1: [nil, a2, nil ]} becomes {q1: [a1]} )
  #4- Any known questions not present as keys are inserted and given [EMPTY] value 
  #5- Any array values that remain empty will become [EMPTY] (e.g. { q1: [] } becomes { q1: [EMPTY ]} )
  def normalise_answers_hash(answers_hash)
    #make sure #2 above is satisfied 
    answers_hash.transform_values!{|v| v.is_a?(Array) ? v : [v]}

    normalised_answers_hash = QUESTIONS.inject(HashWithIndifferentAccess.new)do |hash, q_hash|
      #make sure #3 above is satisfied
      hash[q_hash[:code]].reject!(&:blank?) unless hash[q_hash[:code]].nil?
      #make sure #1, #4 and #5 above is satisfied
      ans_nil_or_empty_arr = answers_hash[q_hash[:code]].nil? || answers_hash[q_hash[:code]].empty? 
      hash[q_hash[:code]] = ans_nil_or_empty_arr ? [EMPTY] : answers_hash[q_hash[:code]]

      hash
    end

    normalised_answers_hash
  end

  #Obtain the content rendered visibleby by a given heading_rule for
  def obtain_content_for_heading(heading_rule, answers_flags)
    content_array  =  heading_rule[:content_rules].inject([]) do |content_array_accumulator, content_rule |
      mask_flags = obtain_trigger_masks(content_rule[:triggers], answers_flags)
      mask_flags = mask_flags.to_i(2)
      #If the mask_flags > 0 (i.e. any of the mask_flags come up as '1') then AND'ing them with the mask produces the mask flag
      #If the mask_flags come back as '0' then the content should be disabled
      content_visible = !(mask_flags==0) && ( mask_flags & content_rule[:mask].to_i(2) == mask_flags )

      #TODO: This is where we shall request the article from CMS and inject it as an element in the content array
      #For now we are simply placing the CMS URL in there
      content_array_accumulator << content_rule[:article] if content_visible

      content_array_accumulator
    end

    content_array

  end

  #Method to iterate over an array of triggers and determine the flags indicating whether the
  #respective trigger was triggered or not by the passed in question/answer flags
  def obtain_trigger_masks(triggers_arr, answers_flags)
    mask_flags = triggers_arr.inject('') do |mask_flags_accumulator,  trigger_val |
      trigger_flags = convert_answers_array_to_flags(trigger_val)
    p "comparing answers flags: #{answers_flags.scan(/.{1,16}/)}"
    p "--To trigger flags #{trigger_flags.scan(/.{1,16}/)}"
    
    #(0...QUESTIONS.length).to_a.inject(false) do |trigd, index|
      #trigd || answers_flags.scan(/.{1,32}/)
    #end
    #TODO: get rid of these hard coded numbers
    triggered = trigger_flags.scan(/.{1,32}/)
      .zip(answers_flags.scan(/.{1,32}/))
      .inject(true) do |trig_pulled, trg_ans_arr|
      trig_ans = trg_ans_arr[0][-16..-1]
      actual_ans = trg_ans_arr[1][-16..-1]
      trig_pulled = trig_pulled && (trig_ans.to_i(2) == 0 || (trig_ans.to_i(2) & actual_ans.to_i(2) == actual_ans.to_i(2))) 
      p "trigAns: #{trig_ans} actualAns: #{actual_ans} trig_pulled: #{trig_pulled}"
      trig_pulled
    end


    #triggerd = trigger_flags.to_i(2) & answers_flags.to_i(2) == trigger_flags.to_i(2)
      p "Triggered: #{triggered}"
      mask_flags_accumulator += triggered ? '1' : '0'

      mask_flags_accumulator
    end
    mask_flags
  end

  #This method accepts a hash of questions and their answers.
  #It output the standardised  flags representation
  def convert_hash_to_flags(question_answers_hash)
    normalised_hash = normalise_answers_hash(question_answers_hash)
    flags = QUESTIONS.inject('') do | flag_str, qn |
      flag_str += qn[:flag]
      ans_flags = qn[:responses].inject(FLAGS[EMPTY]) do |flags, resp|
        flags = FLAG_FORMAT % (flags.to_i(2) | resp[:flag].to_i(2)).to_s(2) if question_answers_hash[qn[:code]].include?(resp[:code])
        flags
      end
      flag_str += ans_flags
    end
    p "qa hash #{question_answers_hash}"
    p "--became flags #{flags.scan(/.{1,16}/)}"
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

  def convert_answers_array_to_flags(answers_array)
    answers_hash = unflatten_answers_array(answers_array)
    flags_str = answers_hash.inject('') do | bit_str, q_a_array |
      bit_str += QUESTIONS_HASH[q_a_array[0]][:flag]

      bit_str += q_a_array[1].inject(FLAGS[EMPTY]) do |flags, ans_str|
        flags = (flags.to_i(2) | ANSWERS_HASH[ans_str][:flag].to_i(2)).to_s(2)
        FLAG_FORMAT % flags
      end

      bit_str
    end

    flags_str
  end
end
