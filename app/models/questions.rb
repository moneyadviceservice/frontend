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

  #This method cosumes the current state of the model and outputs
  # the headers and content that apply to the answers as per the configured rules.
  #It returns an array of section objects each containing an array of headings containing an array of content as below
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
  #the content under each heading is sorted in the same order in which it appears in CONTENT_RULES.
  #
  #NB.
  # - The caller should simply display the values of headings[:content] one after another.
  # - no section entry will be returned for sections with no content to display
  #
  # For now the content is the CMS URL however that will change to the actual content
  # from CMS once integration is achieved
  def results
    answers_hash = to_hash
    Rails.logger.info("Rules engine processing submission: #{answers_hash}")

    sections_array =  CONTENT_RULES.inject([]) do |sections_array_accumulator, section_rules|
      heading_content_array = section_rules[:heading_rules].inject([]) do |content_array, heading_rule|
        content_array << obtain_content_for_heading(heading_rule, answers_hash)
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

    res = sections_array.sort {|s1, s2| /\d*$/.match(s1[section_code])[0].to_i <=> /\d*$/.match(s2[section_code])[0].to_i}
    Rails.logger.info("Rules engine returning results: #{res}")
    res
  end

  private


  #Method returns a hash representation of this Questions instance
  #TODO: This method sits between the instance members and the model. Consider writing tests for it
  def to_hash
    answers_hash = QUESTIONS.inject(HashWithIndifferentAccess.new) do |accumulator_hash, question|
      accumulator_hash[question[:code]] = send("#{ question[:code] }")
      accumulator_hash
    end
    Rails.logger.debug("Before normalisation hash: #{answers_hash}")
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
  def obtain_content_for_heading(heading_rule, answers_hash)
    content_array  =  heading_rule[:content_rules].inject([]) do |content_array_accumulator, content_rule |
      #See docs for `obtain_trigger_masks` to understand how the masks are calculated
      #At this level `content_rule[:mask]` will determine how calcualted result affects whether
      #the content governed by the triggers is displayed or not.
      #By default the mask is a '1' meaning if the first trigger puled then the content will be displayed.
      #The mask must not belonger than the number of triggers though if shorter all the extra triggers are simply ignored
      #It is treated as follows:
      #- all 1's => any one of the trigers being pulled results in the content being displayed (OR logic).
      #- any 0 => the respective trigger is ignored when considering whether or not to display the content.
      #   A quick way to experiment with trigger combinations.
      #- any 1 => the respective trigger if pulled will cause the content to be displayed
      #- all 0's => The content is ALWAYS displayed. The triggers array can be empty because it will not be consulted.
      content_rule_mask = content_rule[:mask].to_i(2)
      result_flags = obtain_trigger_masks(content_rule[:triggers], answers_hash) unless content_rule_mask == 0
      trigger_result_flags = result_flags.nil? ? 0 : result_flags.to_i(2)
      content_visible = content_rule_mask == 0 || ( trigger_result_flags & content_rule_mask > 0 )

      #TODO: This is where we shall request the article from CMS and inject it as an element in the content array
      #For now we are simply placing the CMS URL in there
      content_array_accumulator << content_rule[:article] if content_visible

      content_array_accumulator
    end

    content_array

  end

  #Method to iterate over an array of triggers each representing question-answers that can pull the respective trigger
  #-A trigger is pulled if each and every answer trigger it contains is pulled.
  #- an answer trigger is pulled if:
  #-- the answer trigger is all '0's (these are pulled  irrespective of the answer).
  #-- the answer trigger switches off flags in the answer (meaning there was an overlap between the answer and the trigger)
  #
  #If all answer triggers are pulled as above then the entire trigger is considered pulled.
  #The trigger mask returned by this method contains '1' for triggers that were pulled and '0` for those that were not
  #all in the order that the triggers appear in the rules configuration. This is to feed into higher level 'OR' logic
  #e.g. trigger [a3,a4,a5] => '001110' and trigger [a2,a3] => '011000' share a common answer (i.e. a3)
  #but might exist in different contexts wrt other question/answers thus having slightly different meanings.
  #- Each trigger would be pulled for answers containing 'a3'
  #- answers containing 'a4' alone would only pull the first while those containing 'a2' alone would pull the second
  #The resulting 2 bit mask (one bit for each trigger) can be used for higher level logic to descide whether to pull
  #the collective trigger or not.
  def obtain_trigger_masks(triggers_arr, answers_hash)
    mask_flags = triggers_arr.inject('') do |mask_flags_accumulator,  trigger_val |
      answers_flags = convert_hash_to_flags(answers_hash)
      Rails.logger.debug("Answers hash converted to flags: #{answers_flags.scan(/.{1,32}/).map!{|arrVal| arrVal.scan(/.{1,16}/)}}")

      trigger_flags = convert_answers_array_to_flags(trigger_val)

      #TODO: get rid of these hard coded numbers
      triggered = trigger_flags.scan(/.{1,32}/)
        .zip(answers_flags.scan(/.{1,32}/))
        .inject(true) do |trig_pulled, trg_ans_arr|
        trig_ans = trg_ans_arr[0][-16..-1]
        actual_ans = trg_ans_arr[1][-16..-1]
        trig_pulled = trig_pulled && (trig_ans.to_i(2) == 0 || (trig_ans.to_i(2) & actual_ans.to_i(2) == actual_ans.to_i(2)))
        Rails.logger.debug "trigger answer: #{trig_ans} submitted answer: #{actual_ans} trig_pulled: #{trig_pulled}"
        trig_pulled
      end


      #triggerd = trigger_flags.to_i(2) & answers_flags.to_i(2) == trigger_flags.to_i(2)
      Rails.logger.debug "Content Triggered: #{triggered}"
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
