module Symbols
  #IMPORTANT: #We must enforce the hard limits of the system
  #
  #The masking only works if the question and answer flags are the same width
  #This means there are the following hard limits in the system:
  #- No more than FLAG_SIZE questions can be asked by the system
  #- No Question can have more than FLAG_SIZE answers
  #
  #NB:
  #- FLAG_SIZE represents the larger of [total number of questions] and [maximum number of answers per question]
  #- The output of all computed/created flag values must be validated by validate_flag(flag)  method
  #- Use FLAG_FORMAT to create bit strings from integers in line with FLAG_SIZE
  #
  #Changing the value of FLAG_SIZE is therefore enough should you require the system to handle
  #a different number of questions/answers in line with the above notes
  FLAG_SIZE = 16
  #The flag is a zero left padded FLAG_SIZE long bit long binarry string
  FLAG_FORMAT = "%0#{FLAG_SIZE}i"
  FULL_FLAG_FORMAT = "%0#{FLAG_SIZE*FLAG_SIZE*2}i"
  def self.validate_flag(flag)
    #Can't really process anything if flags exist that we can not handle. Only alternative is to BOMB out
    raise "Flag #{qn_hash[:flag]} for question #{qn_hash[:code]} (index: #{index}) has size: #{qn_hash[:flag].length}. Expected size: #{FLAG_SIZE}" if flag.length != FLAG_SIZE
  end

  EMPTY = 'EMPTY'
  ALL = 'ALL'

  #Set up the flags reference hash/lookup-table that will be used by the system
  FLAGS = HashWithIndifferentAccess.new
  FLAGS[EMPTY] = FLAG_FORMAT % '0'
  FLAGS[ALL] = '1'*FLAG_SIZE
  (0..FLAG_SIZE).to_a.each { |index| FLAGS[index.to_s] = FLAG_FORMAT % (2**(index)).to_s(2) }

  #setup the question/answer hashes
  #- QUESTIONS: An array of all the questions from the yml file enriched with flag information and with the code standadised to lowercase
  #- QUESTIONS_HASH: hash of all the questions keyed on the question code
  #- ANSWERS_HASH: hash containing all possible answer codes (keyed by code) and enriched with the respective flag information
  QUESTIONS_HASH = HashWithIndifferentAccess.new
  ANSWERS_HASH = HashWithIndifferentAccess.new

 
  #Enrich a given question hashbag with flag information and downcased codes
  #As a sideeffect the bag is updated into the QUESTIONS_HASH for faster code based lookup
  def self.enrich_questions(qn_hash)
    index = /\d*$/.match(qn_hash[:code])[0]
    qn_hash[:code].downcase!
    qn_hash[:flag] = FLAGS[index]
    validate_flag(qn_hash[:flag])
    QUESTIONS_HASH[qn_hash[:code]] = qn_hash
    qn_hash[:responses].each do |resp|
      index = /\d*$/.match(resp[:code])[0]
      resp[:code].downcase!
      resp[:flag] = FLAGS[index]
      validate_flag(resp[:flag])
      ANSWERS_HASH[resp[:code]] = resp.slice(:code, :flag)
    end
    qn_hash[:responses].sort! {|r1, r2| /\d*$/.match(r1[:code])[0].to_i <=> /\d*$/.match(r2[:code])[0].to_i}

    qn_hash
  end

  QUESTIONS = I18n.translate('c19_diagnostics_tool.questions')
    .map {| qn_hash | enrich_questions(qn_hash)}
    .sort { |q1, q2| /\d*$/.match(q1[:code])[0].to_i <=> /\d*$/.match(q2[:code])[0].to_i }

  ANSWERS_HASH['EMPTY'] = {code: EMPTY, flag: FLAGS[EMPTY]}


  #TODO: Might be a good idea to move these rules into the translation file though not sure if that'll
  #be placing more in there than we want.
  #- Not a good idea to keep the rules here and the text there... maintenance headache maintaining the header symbols in two places.
  #- Not a good idea to move everything here... translation of headings into other languages will be required going forward.
  #
  #The data representation of the logic that triggers content being displayed
  #Format:
  # [
  #   {
  #     section_code: <Section Code>,
  #     headings: [ <this is the list of headings and their associated content plus triggers as exampled below>
  #       {
  #         heading_code: <header code>,
  #        content:
  #        [<this is the list of content that can appear under a heading. Usually just one article >
  #          {
  #            triggers: [
  #               < a list of the QA combinations whose state triggers display of the content >
  #             ],
  #             masks: [
  #               <A list bitmasks that determins whether the triggers turn the header on or off
  #               each list element must contain as many flags as there are triggers and if any one of these masks
  #               matches the triggers then the content will be displayed>
  #             ],
  #             article: <The CMS URL of the content affected >
  #         }
  #       ]
  #     }
  #   }
  # ]
  #
  # This is effectively a list of section rules.
  # - Each section rule ismade up of a list of heading rules.
  # - Each heading rule is made up of a list of content rules
  # - Each content rule contains
  #   - a list of triggers that produce a 1,0 state depending on whether they are activated or not by the answers (AND logic)
  #   - a mask that is applied to the concatenated result states of the individual triggers (OR logic)
  #   - the content to display if the mask agrees with the state of the triggers
  # which in turn have heading rules
  #
  #NB. the length of the mask: value below should equal the length of the triggers though that requirement is not enforced for additional flexibility
  #If it is shorter then the extra trigers are disregarded
  #e.g with 2 elements in the trigger array generating '11' meaning they are both triggered.
  #the following masks produce the specified content rule outcome
  #- '1' - the content is displayed but only the first mask output is considered i.e (results the same for '11' and '10' output of the triggers)
  #- '0' - the content is displayed only if the first trigger is not pulled irrespective of the state of the other i.e (results the same for '01' and '00' output of the triggers)
  #- '10' - the content is displayed only if the first trigger is pulled and the second is not i.e (results are '10')
  #- '01' - the content is displayed only if the second trigger is pulled and the first is not i.e (results are '01')
  #- '11' - the content is displayed only if both triggers are pulled i.e (results are '11')
  #
  #TODO: Think of a less misleading form of reuse

  MASK_ALL = '11'
  MASK_SOME = '01'
  MASK_NONE = '00'
  COMMON_RULES = {
    debtadvice: {
      #Any of these Q4A1, Q6A6, Q7A1-A9, Q10A3 PLUS the regional variation
      rules: [
        {q4:'a1', q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:'a3'}
      ],
      mask: MASK_SOME
    },
    stepchange: {
      #Any of these Q3A1, Q4A2, Q4A3, Q6A4, Q6A5, Q9A1-A11, Q10A1  BUT NOT IF HAVE ALSO SELECTED Q4A1, Q6A6, Q7A1-A9, Q10A3
      rules: [
        {q3:'a1', q4:['a2', 'a3'], q6:['a4', 'a5'], q9:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11'], q10:['a1']},
        {q4:'a1', q6: ['a6'], q7: ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10: ['a3']},
      ],
      mask: MASK_SOME + MASK_NONE
    },

    debtline: {
      #Show if Q1A2 (self employed flag) plus Q0A1 or Q0A3 or Q0A4 plus any of Q3A2, Q4A1, Q5A3, Q6A6, Q7A1-A9, Q10A3
      rules: [
        {q1:'a2'},
        {q3:['a2'], q4:['a1'], q5:['a3'], q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:['a3']},
      ],
      mask: MASK_ALL + MASK_SOME
    }
  }

  CONTENT_RULES = [
    {
      #'Urgent Actions' section
      section_code: 'S1',
      heading_rules: [

        {
          #Get Free debt advice now' Rules
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                {q0:'a1'}
              ] + COMMON_RULES[:debtadvice][:rules],
              mask: MASK_ALL + COMMON_RULES[:debtadvice][:mask],
              article: "coronavirus-debt-advice-england"
            },
            {
              triggers: [
                {q0:'a2'}
              ] + COMMON_RULES[:debtadvice][:rules],
              mask: MASK_ALL + COMMON_RULES[:debtadvice][:mask],
              article: "coronavirus-debt-advice-ni"
            },
            {
              triggers: [
                {q0:'a3'}
              ] + COMMON_RULES[:debtadvice][:rules],
              mask: MASK_ALL + COMMON_RULES[:debtadvice][:mask],
              article: "coronavirus-debt-advice-scotland"
            },
            {
              triggers: [
                {q0:'a4'}
              ] + COMMON_RULES[:debtadvice][:rules],
              mask: MASK_ALL + COMMON_RULES[:debtadvice][:mask],
              article: "coronavirus-debt-advice-wales"
            }
          ]
        },

        {
          #'Contact Stepchange Covid response' heading rules
          heading_code: 'H2',
          content_rules: [
            {
              triggers: [
                {q0:'a1'}
              ] + COMMON_RULES[:stepchange][:rules],
              mask: MASK_ALL + COMMON_RULES[:stepchange][:mask],
              article: "coronavirus-stepchange-debt-england"
            },
            {
              triggers: [
                {q0:'a2'}
              ] + COMMON_RULES[:stepchange][:rules],
              mask: MASK_ALL + COMMON_RULES[:stepchange][:mask],
              article: "coronavirus-stepchange-debt-ni"
            },
            {
              triggers: [
                {q0:'a3'}
              ] + COMMON_RULES[:stepchange][:rules],
              mask: MASK_ALL + COMMON_RULES[:stepchange][:mask],
              article: "coronavirus-stepchange-debt-scotland"
            },
            {
              triggers: [
                {q0:'a4'}
              ] + COMMON_RULES[:stepchange][:rules],
              mask: MASK_ALL + COMMON_RULES[:stepchange][:mask],
              article: "coronavirus-stepchange-debt-wales"
            },
          ]
        },

        {
          #'SELF EMPLOYED DEBT ADVICE Contact Business Debtline for England' heading rules
          heading_code: 'H3',
          content_rules: [
            {
              triggers: [
                {q0:['a1', 'a3', 'a4']}
              ] + COMMON_RULES[:debtline][:rules],
              mask: MASK_SOME + COMMON_RULES[:debtline][:mask],
              article: "coronavirus-self-employed-debt-advice"
            },

            {
              triggers: [
                {q0:['a2']}
              ] + COMMON_RULES[:debtline][:rules],
              mask: MASK_ALL + COMMON_RULES[:debtline][:mask],
              article: "coronavirus-self-employed-debt-advice-ni"
            }
          ]
        }
      ]
    }
  ]
end

