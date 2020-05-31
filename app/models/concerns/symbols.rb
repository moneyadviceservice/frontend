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
  def validate_flag(flag)
    #Can't really process anything if flags exist that we can not handle. Only alternative is to BOMB out
    raise "Flag #{qn_hash[:flag]} for question #{qn_hash[:code]} (index: #{index}) has size: #{qn_hash[:flag].length}. Expected size: #{FLAG_SIZE}" if flag.length != FLAG_SIZE
  end

  EMPTY = 'EMPTY'
  #
  #Set up the flags reference hash/lookup-table that will be used by the system
  FLAGS = HashWithIndifferentAccess.new  
  FLAGS[EMPTY] = 0
  (1..FLAG_SIZE).to_a.each { |index| FLAGS[index.to_s] = 2**(index-1) } 

  #setup the question/answer hashes
  #- QUESTIONS: An array of all the questions from the yml file enriched with flag information and with the code standadised to lowercase 
  #- QUESTIONS_HASH: hash of all the questions keyed on the question code
  #- ANSWERS_HASH: hash containing all possible answer codes (keyed by code) and enriched with the respective flag information
  QUESTIONS_HASH = HashWithIndifferentAccess.new
  ANSWERS_HASH = HashWithIndifferentAccess.new

  #Enrich a given question hashbag with flag information and downcased codes
  #As a sideeffect the bag is updated into the QUESTIONS_HASH for faster code based lookup
  def enrich_questions(qn_hash)
    index = /\d*$/.match(qn_hash[:code])[0]
    qn_hash[:code].downcase!
    qn_hash[:flag] = FLAG_FORMAT % FLAGS[index.to_sym].to_s(2)
    validate_flag(qn_hash[:flag])
    QUESTIONS_HASH[qn_hash[:code]] = qn_hash
    qn_hash[:responses].each do |resp|
      index = /\d*$/.match(resp[:code])[0]
      resp[:code].downcase!
      resp[:flag] = FLAG_FORMAT % FLAGS[index.to_sym].to_s(2)
      validate_flag(resp[:flag])
      ANSWERS_HASH[resp[:code]] = resp.slice(:code, :flag)
    end
    qn_hash[:responses].sort! {|r1, r2| r1[:code] <=> r2[:code]}

    qn_hash
  end

  QUESTIONS = I18n.translate('c19_diagnostics_tool.questions')
    .map{| qn_hash | enrich_questions(qn_hash)}
    .sort(|q1, q2| q1[:code] <=> q2[:code])

  ANSWERS_HASH['EMPTY'] = {code: EMPTY, flag: FLAGS[EMPTY.to_sym]}

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
  RESULTS = [
    {
      section_code: 'S1',
      headings: [
        {
          heading_code: 'H1',

          #TODO: this belongs in the translation files
          #text: 'Urgent actions',
          #TODO: this belongs in the translation files
          #text: 'Get free Debt advice now (DALT)',
          content: [
            {
              triggers: [
                %w[q0_a1 q4_a1 q6_a4, q6_a5, q6_a6, q7_a1 q7_a2 q7_a3 q7_a4 q7_a5 q7_a6 q7_a7 q7_a8 q7_a9 q10_a3]
              ],
              mask: '1',
              article: "corona_virus_urgent_action_england"
            },
            {
              triggers: [
                %w[q0_a2 q4_a1 q6_a4, q6_a5, q6_a6, q7_a1 q7_a2 q7_a3 q7_a4 q7_a5 q7_a6 q7_a7 q7_a8 q7_a9 q10_a3]
              ],
              mask: '1',
              article: "coronavirus-debt-advice-ni"
            },
            {
              triggers: [
                %w[q0_a3 q4_a1 q6_a4, q6_a5, q6_a6, q7_a1 q7_a2 q7_a3 q7_a4 q7_a5 q7_a6 q7_a7 q7_a8 q7_a9 q10_a3]
              ],
              mask: '1',
              article: "coronavirus-debt-advice-scotland"
            },
            {
              triggers: [
                %w[q0_a4 q4_a1 q6_a4, q6_a5, q6_a6, q7_a1 q7_a2 q7_a3 q7_a4 q7_a5 q7_a6 q7_a7 q7_a8 q7_a9 q10_a3]
              ],
              mask: '1',
              article: "coronavirus-debt-advice-wales"
            }
          ]
        }
      ]
    }
  ]
end

