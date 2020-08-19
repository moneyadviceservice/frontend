module MoneyNavigator
  # frozen_string_literal: true

  # This is not intended as an active record model and could just as well be seen as a form
  # It will have model logic so I placed it in the models, that does not mean that
  # it should be made a DB model for the release
  #
  class Questions
    include ActiveModel::Model
    include MoneyNavigator::Constants
    include MoneyNavigator::Symbols

    #Dynamically setup the validateable instance fields that will be populated
    #when the model isinitialised and can be validated after initialisation
    QUESTIONS.each do | qn |
      question = qn[:code].to_s.downcase.to_sym
      attr_accessor question
      validates question, presence: true
    end

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

      sections_array =  MoneyNavigator::ContentRules.all.inject([]) do |sections_array_accumulator, section_rules|
        heading_content_array = section_rules[:heading_rules].inject([]) do |heading_content, heading_rule|
          heading_content << { heading_code: heading_rule[:heading_code], content: obtain_content_for_heading(heading_rule, answers_hash) }
          heading_content
        end

        heading_content_array.reject! { |heading_element| heading_element[:content].empty? }
        if !heading_content_array.empty?
          section_hash = HashWithIndifferentAccess.new
          section_hash[:section_code] = section_rules[:section_code]
          section_hash[:headings] = heading_content_array.sort {|h1, h2| /\d*$/.match(h1[:heading_code])[0].to_i <=> /\d*$/.match(h2[:heading_code])[0].to_i}
          sections_array_accumulator << section_hash
        end

        sections_array_accumulator
      end

      res = sections_array.sort {|s1, s2| /\d*$/.match(s1[:section_code])[0].to_i <=> /\d*$/.match(s2[:section_code])[0].to_i}
      Rails.logger.info("Rules engine returning results: #{res}")
      res
    end

    private


    #Method returns a hash representation of this Questions instance
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
      content  =  heading_rule[:content_rules].inject({}) do |content_accumulator, content_rule |
        #See docs for `obtain_trigger_masks` to understand how the masks are calculated
        #At this level `content_rule[:mask]` is simply the expected results of the triggers.
        #It is compared with the combined trigger result to decide whether the content governed by the triggers is displayed or not.
        #By default the mask is a '1' meaning if the first trigger is pulled and no other triggers exist then the content will be displayed.
        #The mask must be as long as the number of triggers. Content will be disabled by default if this is not the case.
        #In summary, content will be displayed if the mask is completely equal to the trigger results.
        Rails.logger.debug "Checking Triggers for content: #{content_rule[:article]}"
        result_flags = obtain_trigger_masks(content_rule[:triggers], answers_hash)
        content_visible = content_rule[:mask].include? result_flags
        Rails.logger.debug(" content_rule_mask: #{content_rule[:mask]}, results_flags: #{result_flags},  content_visible:#{content_visible}")

        Rails.logger.debug "Finished checking Triggers for content: #{content_rule[:article]}"
        content_accumulator[:html] = cms_content(content_rule[:article]) if content_visible
        content_accumulator[:url] = content_rule[:article] if content_visible

        content_accumulator
      end

      content
    end

    def cms_content(slug)
      action_plan_page = Mas::Cms::ActionPlan.find(slug, locale: I18n.locale, cached: true)
      action_plan_page.body
    rescue StandardError => ex
      Rails.logger.error "Failed to load content from CMS. Slug: #{slug}; Ex: #{ex}"
      "ERROR: CMS CONTENT '#{slug}' NOT AVAILABLE"
    end

    #Method to iterate over an array of triggers each representing question-answers that can pull the respective trigger
    #-A trigger is pulled if each and every answer sub-trigger it contains is pulled.
    #- an answer sub-trigger is pulled if:
    #-- All previous answer sub-triggers were pulled (no use pulling if some answers sub-triggers have already failed to pull)
    #     AND (
    #-- the answer sub-trigger is all '0's (these `i dont care what they chose` sub-triggers are pulled  irrespective of the answer).
    #       OR
    #-- the answer sub-trigger does not mask out all the flags in the answer (meaning there was an overlap between the answer and the sub-trigger)
    #         )
    #If all answer sub-triggers are pulled as above then the entire trigger is considered pulled.
    #NB. debug logging has been enhanced to make investigation of issues easier
    #
    #The trigger mask returned by this method contains '1' for triggers that were pulled and '0` for those that were not
    #all in the order that the triggers appear in the rules configuration. This is to feed into higher level 'OR' logic
    #e.g. trigger [a3,a4,a5] => '001110' and trigger [a2,a3] => '011000' share a common answer (i.e. a3)
    #but might exist in different contexts wrt other question/answers thus having slightly different meanings.
    #- Each trigger would be pulled for answers containing 'a3'
    #- answers containing 'a4' alone would only pull the first while those containing 'a2' alone would pull the second
    #The resulting 2 bit mask (one bit for each trigger) can be used for higher level logic to descide whether to pull
    #the collective trigger or not.
    def obtain_trigger_masks(triggers_arr, answers_hash)
      Rails.logger.debug("Given the answers: #{answers_hash}")

      mask_flags = triggers_arr.inject('') do |mask_flags_accumulator,  trigger_hash |
        Rails.logger.debug("... and considering the trigger: #{trigger_hash}")
        question_answers_flags_hash = convert_hash_to_flags(answers_hash)
        question_answers_flags = question_answers_flags_hash[:all].to_i(2)
        Rails.logger.debug("Answers flags: #{question_answers_flags_hash[:all].scan(/.{1,#{FLAG_SIZE}}/)}")
        triggers_flags_hash = convert_hash_to_flags(HashWithIndifferentAccess.new(trigger_hash))
        triggers_flags = triggers_flags_hash[:all].to_i(2)
        Rails.logger.debug("Triggers flags: #{triggers_flags_hash[:all].scan(/.{1,#{FLAG_SIZE}}/)}")

        none_fired = triggers_flags & question_answers_flags == 0
        exact_fired = none_fired ? false :  triggers_flags & question_answers_flags == triggers_flags
        some_fired = exact_fired ? true : triggers_flags & question_answers_flags > 0

        Rails.logger.debug("None fired: #{none_fired} Exact fired: #{exact_fired}, Some fired: #{some_fired}" )

        the_mask = MASK_NONE if none_fired
        the_mask = MASK_SOME if some_fired
        the_mask = MASK_ALL if exact_fired
        mask_flags_accumulator += the_mask
        Rails.logger.debug "Trigger result: #{mask_flags_accumulator}"

        mask_flags_accumulator
      end
      mask_flags
    end

    #This method accepts a hash of questions and their answers.
    #It output the standardised hash of the same questions and their answers flags representation of the answers
    #i.e. {
    #       'q0': '0001110101010100'
    #       'q1': '0001011111010110'
    #       ...
    #       }
    #}
    def convert_hash_to_flags(question_answers_hash)
      normalised_hash = normalise_answers_hash(question_answers_hash)
      qn_flags_hash = HashWithIndifferentAccess.new
      qn_flags_hash[:all] = ''
      question_flags_hash = QUESTIONS.inject(qn_flags_hash) do | acc_qn_flags_hash, qn |
        ans_flags = qn[:responses].inject(FLAGS[EMPTY]) do |flags, resp|
        flags = FLAG_FORMAT % (flags.to_i(2) | resp[:flag].to_i(2)).to_s(2) if normalised_hash[qn[:code]].include?(resp[:code])
        flags
      end

      acc_qn_flags_hash[qn[:code]] = ans_flags
      acc_qn_flags_hash[:all] += ans_flags

      acc_qn_flags_hash
      end
      question_flags_hash
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
end
