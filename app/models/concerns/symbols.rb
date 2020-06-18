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
#TODO move the sections into seperate files to make the rules easier to manage
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
        },

        {
          #'Pensions content' heading rules
          heading_code: 'H4',
          content_rules: [
            {
              triggers: [
                {q12:['a2']}
              ],
              mask: MASK_ALL,
              article: "urgent-pension-advice"
            },

          ]
        }
      ]
    },

    {
      #'Payment Holidays' section
      section_code: 'S2',
      heading_rules: [

        {
          #'Mortgage payment holidays' Rules
          heading_code: 'H2.1',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a1'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-mortgage-payment-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a1'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-mortgage-payment-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a1'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-mortgage-payment-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a1'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-mortgage-payment-no-change"
            },
          ]
        },

        {
          #'Personal loan payment holidays' Rules
          heading_code: 'H2.2',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a2'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-personal-loan-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a2'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-personal-loan-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a2'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-personal-loan-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a2'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-personal-loan-no-change"
            },
          ]
        },

        {
          #'Credit card payment holidays' Rules
          heading_code: 'H2.3',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a3'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-credit-card-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a3'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-credit-card-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a3'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-credit-card-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a3'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-credit-card-no-change"
            },
          ]
        },

        {
          #'Store card payment holidays' Rules
          heading_code: 'H2.4',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a4'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-store-card-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a4'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-store-card-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a4'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-store-card-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a4'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-store-card-no-change"
            },
          ]
        },

        {
          #'Car finance payment holidays' Rules
          heading_code: 'H2.5',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a5'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-car-finance-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a5'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-car-finance-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a5'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-car-finance-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a4'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-car-finance-no-change"
            },
          ]
        },

        {
          #'Buy now pay later payment holidays (eg Klarma)' Rules
          heading_code: 'H2.6',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a6'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-buy-now-pay-later-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a6'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-buy-now-pay-later-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a6'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-buy-now-pay-later-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a6'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-buy-now-pay-later-no-change"
            },
          ]
        },

        {
          #'Rent to own payment holidays' Rules
          heading_code: 'H2.7',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a7'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-rent-to-own-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a7'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-rent-to-own-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a7'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-rent-to-own-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a7'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-rent-to-own-no-change"
            },
          ]
        },

        {
          #'Payday loan payment holidays' Rules
          heading_code: 'H2.8',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a8'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-payday-loan-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a8'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-payday-loan-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a8'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-payday-loan-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a8'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-payday-loan-no-change"
            },
          ]
        },

        {
          #'Pawnbroker payment holidays' Rules
          heading_code: 'H2.9',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a9'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-pawnbroker-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a9'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-pawnbroker-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a9'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-pawnbroker-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a9'}
              ] ,
              mask: MASK_ALL,
              article: "coronavirus-holiday-pawnbroker-no-change"
            },
          ]
        },

      ]
    },

    {
      #'Your money moving forward ' section
      section_code: 'S3',
      heading_rules: [

        {
          #'Getting back on track after an income drop ' Rules
          heading_code: 'H3.1',
          content_rules: [
            {
              triggers: [
                {q4:'a1'}
              ],
              mask: MASK_ALL,
              article: "coronavirus-back-on-track-severe"
            },
          ]
        },

        {
          #'Getting back on track after a severe income drop' Rules
          heading_code: 'H3.2',
          content_rules: [
            {
              triggers: [
                {q4: ['a2', 'a3']}
              ],
              mask: MASK_SOME,
              article: "coronavirus-back-on-track"
            },
          ]
        },

        {
          #'Looking forward after the COVID pandemic' Rules
          heading_code: 'H3.3',
          content_rules: [
            {
              triggers: [
                {q4: 'a4'}
              ],
              mask: MASK_ALL,
              article: "coronavirus-looking-forward"
            },
          ]
        },

      ]
    },

    {
      #'Money and work' section
      section_code: 'S4',
      heading_rules: [

        {
          #' Managing your money when you’re self employed ' Rules
          heading_code: 'H4.1',
          content_rules: [
            {
              triggers: [
                {q1:'a2'}
              ],
              mask: MASK_ALL,
              article: "coronavirus-managing-self-employed"
            },
          ]
        },

        {
          #'Urgent help if you're self employed' Rules
          heading_code: 'H4.2',
          content_rules: [
            {
              triggers: [
                {q0: ['a1', 'a3', 'a4']},
                {q1: 'a2', q4: 'a1'},
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-urgent-help-self-employed"
            },
            {
              triggers: [
                {q0: 'a2'},
                {q1: 'a2', q4: 'a1'},
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-urgent-help-self-employed-ni"
            },
          ]
        },

        {
          #' Preparing for redundancy ' Rules
          heading_code: 'H4.3',
          content_rules: [
            {
              triggers: [
                {q1: 'a1'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-preparing-redundancy"
            },
          ]
        },

        {
          #' What to do if you`re unemployed' Rules
          heading_code: 'H4.4',
          content_rules: [
            {
              triggers: [
                {q1: 'a3'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-unemployed"
            },
          ]
        },

      ]
    },

    {
      #'Staying on top of housing costs' section
      section_code: 'S5',
      heading_rules: [

        {
          #'If you`ve missed one mortgage or rent payment' Rules
          heading_code: 'H5.1',
          content_rules: [
            {
              triggers: [
                {q6: [ 'a4', 'a5', 'a6' ]}
              ],
              mask: MASK_SOME,
              article: "missed-rent-mortgage-low"
            },
          ]
        },

        {
          #' If you’re worried about rent payments (renting privately)' Rules
          heading_code: 'H5.2',
          content_rules: [
            {
              triggers: [
                {q0: 'a1', q6: 'a1'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-private-england"
            },
            {
              triggers: [
                {q0: 'a2', q6: 'a1'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-private-ni"
            },
            {
              triggers: [
                {q0: 'a3', q6: 'a1'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-private-scotland"
            },
            {
              triggers: [
                {q0: 'a4', q6: 'a1'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-private-wales"
            },
          ]
        },

        {
          #' If you’re worried about rent payments (social housing' Rules
          heading_code: 'H5.3',
          content_rules: [
            {
              triggers: [
                {q0: 'a1', q6: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-social-england"
            },
            {
              triggers: [
                {q0: 'a2', q6: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-social-ni"
            },
            {
              triggers: [
                {q0: 'a3', q6: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-social-scotland"
            },
            {
              triggers: [
                {q0: 'a4', q6: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-rent-social-wales"
            },
          ]
        },

        {
          #' If you’re worried about mortgage payments ' Rules
          heading_code: 'H5.4',
          content_rules: [
            {
              triggers: [
                {q0: 'a1', q6: 'a3'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-mortgage-payments"
            },
            {
              triggers: [
                {q0: 'a2', q6: 'a3'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-mortgage-payments"
            },
            {
              triggers: [
                {q0: 'a3', q6: 'a3'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-mortgage-payments-scotland"
            },
            {
              triggers: [
                {q0: 'a4', q6: 'a3'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-mortgage-payments-wales"
            },
          ]
        },

        {
          #'If you’re behind with rent payments because of COVID-19' Rules
          heading_code: 'H5.5',
          content_rules: [
            {
              triggers: [
                {q0: 'a1', q6: 'a4'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-behind-rent-england"
            },
            {
              triggers: [
                {q0: 'a2', q6: 'a4'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-behind-rent-ni"
            },
            {
              triggers: [
                {q0: 'a3', q6: 'a4'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-behind-rent-scotland"
            },
            {
              triggers: [
                {q0: 'a4', q6: 'a4'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-behind-rent-wales"
            },
          ]
        },

        {
          #'If you’re behind with mortgage payments because of COVID-19' Rules
          heading_code: 'H5.6',
          content_rules: [
            {
              triggers: [
                {q0: 'a1', q6: 'a5'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-behind-mortgage"
            },
            {
              triggers: [
                {q0: 'a2', q6: 'a5'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-behind-mortgage"
            },
            {
              triggers: [
                {q0: 'a3', q6: 'a5'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-behind-mortgage-scotland"
            },
            {
              triggers: [
                {q0: 'a4', q6: 'a5'},
                {q8: 'a1'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-behind-mortgage-wales"
            },
          ]
        },

      ]
    },

    {
      #'Staying on top of priority bills' section
      section_code: 'S6',
      heading_rules: [

        {
          #'If you`ve missed one payment' Rules
          #Q7A1 or Q7A2 or Q7A3 or Q7A4 or Q7A5 or Q7A6 or Q7A7 or Q7A8 or Q7A9
          heading_code: 'H6.01',
          content_rules: [
            {
              triggers: [
                {q7: ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'] }
              ],
              mask: MASK_SOME,
              article: "missed-payment-low"
            },
          ]
        },

        {
          #'What to do about paying your Council Tax (Domestic Rates Northern Ireland)' Rules
          heading_code: 'H6.02',
          content_rules: [
            {
              #Q7A1, Q4A1 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                {q0: ['a1', 'a3', 'a4'] },
                {q7: 'a1', q4: 'a1' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-council-tax-severe"
            },
            {
              #Q7A1, Q4A1, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a1', q4: 'a1' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-domestic-rates-severe"
            },
            {
              #Q7A1, Q4A2 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                {q0: ['a1', 'a3', 'a4'] },
                {q7: 'a1', q4: 'a2' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-council-tax-temp-worried"
            },
            {
              #Q7A1, Q4A2, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a1', q4: 'a2' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-domestic-rates-temp-worried"
            },
            {
              #Q7A1, Q4A3 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                {q0: ['a1', 'a3', 'a4'] },
                {q7: 'a1', q4: 'a3' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-council-tax-temp-normal"
            },
            {
              #Q7A1, Q4A4, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a1', q4: 'a3' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-domestic-rates-temp-normal"
            },
            {
              #Q7A1, Q4A4 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                {q0: ['a1', 'a3', 'a4'] },
                {q7: 'a1', q4: 'a4' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-council-tax-no-change"
            },
            {
              #Q7A1, Q4A4, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a1', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-domestic-rates-no-change"
            },
          ]
        },

        {
          #'What to do about paying your gas or electricity bill' Rules
          heading_code: 'H6.03',
          content_rules: [
            {
              #Q7A2, Q4A1
              triggers: [
                {q7: 'a2', q4: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-gas-electricity-severe"
            },
            {
              #Q7A2, Q4A2
              triggers: [
                {q7: 'a2', q4: 'a2' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-gas-electricity-temp-worried"
            },
            {
              #Q7A2, Q4A3
              triggers: [
                {q7: 'a2', q4: 'a3' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-gas-electricity-temp-normal"
            },
            {
              #Q7A2, Q4A4
              triggers: [
                {q7: 'a2', q4: 'a4' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-gas-electricity-no-change"
            },
          ]
        },

        {
          #'What to do about payments to DWP/HMRC' Rules
          heading_code: 'H6.04',
          content_rules: [
            {
              #Q7A3, Q4A1
              triggers: [
                {q7: 'a3', q4: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-dmp-hmrc-severe"
            },
            {
              #Q7A3, Q4A2
              triggers: [
                {q7: 'a3', q4: 'a2' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-dmp-hmrc-temp-worried"
            },
            {
              #Q7A3, Q4A3
              triggers: [
                {q7: 'a3', q4: 'a3' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-dmp-hmrc-temp-normal"
            },
            {
              #Q7A3, Q4A4
              triggers: [
                {q7: 'a3', q4: 'a4' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-dmp-hmrc-no-change"
            },
          ]
        },

        {
          #'What to do about paying your TV Licence' Rules
          heading_code: 'H6.05',
          content_rules: [
            {
              #Q7A4, Q4A1
              triggers: [
                {q7: 'a4', q4: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-tv-licence-severe"
            },
            {
              #Q7A4, Q4A2
              triggers: [
                {q7: 'a4', q4: 'a2' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-tv-licence-temp-worried"
            },
            {
              #Q7A4, Q4A3
              triggers: [
                {q7: 'a4', q4: 'a3' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-tv-licence-temp-normal"
            },
            {
              #Q7A4, Q4A4
              triggers: [
                {q7: 'a4', q4: 'a4' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-tv-licence-no-change"
            },
          ]
        },

        {
          #'What to do about paying your Income Tax bill' Rules
          heading_code: 'H6.06',
          content_rules: [
            {
              #Q7A5, Q4A1
              triggers: [
                {q7: 'a5', q4: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-income-tax-severe"
            },
            {
              #Q7A5, Q4A2
              triggers: [
                {q7: 'a5', q4: 'a2' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-income-tax-temp-worried"
            },
            {
              #Q7A5, Q4A3
              triggers: [
                {q7: 'a5', q4: 'a3' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-income-tax-temp-normal"
            },
            {
              #Q7A5, Q4A4
              triggers: [
                {q7: 'a5', q4: 'a4' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-income-tax-no-change"
            },
          ]
        },

        {
          #'What to do about paying your child maintenance ' Rules
          heading_code: 'H6.07',
          content_rules: [
            {
              #Q7A6, Q4A1
              triggers: [
                {q7: 'a6', q4: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-child-maintenance-severe"
            },
            {
              #Q7A6, Q4A2
              triggers: [
                {q7: 'a6', q4: 'a2' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-child-maintenance-temp-worried"
            },
            {
              #Q7A6, Q4A3
              triggers: [
                {q7: 'a6', q4: 'a3' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-child-maintenance-temp-normal"
            },
            {
              #Q7A6, Q4A4
              triggers: [
                {q7: 'a6', q4: 'a4' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-child-maintenance-no-change"
            },
          ]
        },

        {
          #'What to do about paying court fines' Rules
          heading_code: 'H6.08',
          content_rules: [
            {
              #Q7A7, Q4A1 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a7', q4: 'a1' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-court-fines-severe"
            },
            {
              #Q7A7, Q4A1, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a7', q4: 'a1' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-severe-ni"
            },
            {
              #Q7A7, Q4A1, Q0A3
              triggers: [
                {q0: ['a3'] },
                {q7: 'a7', q4: 'a1' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-severe-scotland"
            },
            {
              #Q7A7, Q4A2 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a7', q4: 'a2' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-court-fines-temp-worried"
            },
            {
              #Q7A7, Q4A2, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a7', q4: 'a2' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-temp-worried-ni"
            },
            {
              #Q7A7, Q4A2, Q0A3
              triggers: [
                {q0: ['a3'] },
                {q7: 'a7', q4: 'a2' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-temp-worried-scotland"
            },
            {
              #Q7A7, Q4A3 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a7', q4: 'a3' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-court-fines-temp-normal"
            },
            {
              #Q7A7, Q4A4, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a7', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-temp-normal-ni"
            },
            {
              #Q7A7, Q4A4, Q0A3
              triggers: [
                {q0: ['a3'] },
                {q7: 'a7', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-temp-normal-scotland"
            },
            {
              #Q7A7, Q4A4 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a7', q4: 'a4' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-court-fines-no-change"
            },
            {
              #Q7A7, Q4A4, Q0A2
              triggers: [
                {q0: ['a2'] },
                {q7: 'a7', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-no-change-ni"
            },
            {
              #Q7A7, Q4A4, Q0A3
              triggers: [
                {q0: ['a3'] },
                {q7: 'a7', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-court-fines-no-change-scotland"
            },
          ]
        },

        {
          #'What to do about hire purchase agreements' Rules
          heading_code: 'H6.09',
          content_rules: [
            {
              #Q7A8, Q4A1
              triggers: [
                {q7: 'a8', q4: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-hire-purchase-severe"
            },
            {
              #Q7A8, Q4A2
              triggers: [
                {q7: 'a8', q4: 'a2' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-hire-purchase-temp-worried"
            },
            {
              #Q7A8, Q4A3
              triggers: [
                {q7: 'a8', q4: 'a3' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-hire-purchase-temp-normal"
            },
            {
              #Q7A8, Q4A4
              triggers: [
                {q7: 'a8', q4: 'a4' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-hire-purchase-no-change"
            },
          ]
        },

        {
          #'What to do about car parking fines?' Rules
          heading_code: 'H6.10',
          content_rules: [
            {
              #Q7A9, Q4A1 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a9', q4: 'a1' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-car-park-severe"
            },
            {
              #Q7A9, Q4A1, Q0A2
              triggers: [
                {q0: 'a2' },
                {q7: 'a9', q4: 'a1' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-severe-ni"
            },
            {
              #Q7A9, Q4A1, Q0A3
              triggers: [
                {q0: 'a3' },
                {q7: 'a9', q4: 'a1' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-severe-scotland"
            },
            {
              #Q7A9, Q4A2 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a9', q4: 'a2' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-car-park-temp-worried"
            },
            {
              #Q7A9, Q4A2, Q0A2
              triggers: [
                {q0: 'a2' },
                {q7: 'a9', q4: 'a2' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-temp-worried-ni"
            },
            {
              #Q7A9, Q4A2, Q0A3
              triggers: [
                {q0: 'a3' },
                {q7: 'a9', q4: 'a2' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-temp-worried-scotland"
            },
            {
              #Q7A9, Q4A3 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a9', q4: 'a3' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-car-park-temp-normal"
            },
            {
              #Q7A9, Q4A4, Q0A2
              triggers: [
                {q0: 'a2' },
                {q7: 'a9', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-temp-normal-ni"
            },
            {
              #Q7A9, Q4A4, Q0A3
              triggers: [
                {q0: 'a3' },
                {q7: 'a9', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-temp-normal-scotland"
            },
            {
              #Q7A9, Q4A4 and Q0A1 or Q0A4
              triggers: [
                {q0: ['a1', 'a4'] },
                {q7: 'a9', q4: 'a4' },
              ],
              mask: MASK_SOME + MASK_ALL,
              article: "coronavirus-car-park-no-change"
            },
            {
              #Q7A9, Q4A4, Q0A2
              triggers: [
                {q0: 'a2' },
                {q7: 'a9', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-no-change-ni"
            },
            {
              #Q7A9, Q4A4, Q0A3
              triggers: [
                {q0: 'a3' },
                {q7: 'a9', q4: 'a4' },
              ],
              mask: MASK_ALL + MASK_ALL,
              article: "coronavirus-car-park-no-change-scotland"
            },
          ]
        },

      ]
    },

    {
      #'Staying on top of non-priority bills' section
      section_code: 'S7',
      heading_rules: [

        {
          #'Personal loan payments' Rules
          heading_code: 'H7.01',
          content_rules: [
            #Q9A1, Q4A1 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-personal-loan-severe"
            },
            #Q9A1, Q4A2 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-personal-loan-temp-worried"
            },
            #Q9A1, Q4A3 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-personal-loan-temp-normal"
            },
            #Q9A1, Q4A4 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-personal-loan-no-change"
            },
          ]
        },

      {
          #'Water bill' Rules
          heading_code: 'H7.02',
          content_rules: [
            #Q9A2, Q4A1
            {
              triggers: [
                {q4: 'a1', q9: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-water-severe"
            },
            #Q9A2, Q4A2
            {
              triggers: [
                {q4: 'a2', q9: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-water-temp-worried"
            },
            #Q9A2, Q4A3
            {
              triggers: [
                {q4: 'a3', q9: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-water-temp-normal"
            },
            #Q9A2, Q4A4
            {
              triggers: [
                {q4: 'a4', q9: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-water-no-change"
            },
          ]
        },

        {
          #'Mobile phone, TV or broadband' Rules
          heading_code: 'H7.03',
          content_rules: [
            #Q8A3, Q4A1
            {
              triggers: [
                {q4: 'a1', q8: 'a3'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-mobile-tv-broadband-severe"
            },
            #Q9A3, Q4A2
            {
              triggers: [
                {q4: 'a2', q9: 'a3'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-mobile-tv-broadband-temp-worried"
            },
            #Q9A3, Q4A3
            {
              triggers: [
                {q4: 'a3', q9: 'a3'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-mobile-tv-broadband-temp-normal"
            },
            #Q9A3, Q4A4
            {
              triggers: [
                {q4: 'a4', q9: 'a3'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-water-no-change"
            },
          ]
        },

        {
          #'Credit card payments' Rules
          heading_code: 'H7.04',
          content_rules: [
            #Q9A4, Q4A1 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-credit-card-severe"
            },
            #Q9A4, Q4A2 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-credit-card-temp-worried"
            },
            #Q9A4, Q4A3 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-credit-card-temp-normal"
            },
            #Q9A4, Q4A4 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-credit-card-no-change"
            },
          ]
        },

        {
          #'Store card payments' Rules
          heading_code: 'H7.05',
          content_rules: [
            #Q9A5, Q4A1 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-store-card-severe"
            },
            #Q9A5, Q4A2 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-store-card-temp-worried"
            },
            #Q9A5, Q4A3 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-store-card-temp-normal"
            },
            #Q9A5, Q4A4 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-store-card-no-change"
            },
          ]
        },

        {
          #'Car finance payments' Rules
          heading_code: 'H7.06',
          content_rules: [
            #Q9A6, Q4A1 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-car-finance-severe"
            },
            #Q9A6, Q4A2 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-car-finance-temp-worried"
            },
            #Q9A6, Q4A3 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-car-finance-temp-normal"
            },
            #Q9A6, Q4A4 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-car-finance-no-change"
            },
          ]
        },

        {
          #'Buy now pay later payments (eg Klarma)' Rules
          heading_code: 'H7.07',
          content_rules: [
            #Q9A7, Q4A1 HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-buy-now-pay-later-severe"
            },
            #Q9A7, Q4A2  HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-buy-now-pay-later-temp-worried"
            },
            #Q9A7, Q4A3  HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-buy-now-pay-later-temp-normal"
            },
            #Q9A7, Q4A4 HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-buy-now-pay-later-no-change"
            },
          ]
        },

        {
          #'Rent to own payments' Rules
          heading_code: 'H7.08',
          content_rules: [
            #Q9A8, Q4A1 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-rent-to-own-severe"
            },
            #Q9A8, Q4A2 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-rent-to-own-temp-worried"
            },
            #Q9A8, Q4A3 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-rent-to-own-temp-normal"
            },
            #Q9A8, Q4A4 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-rent-to-own-no-change"
            },
          ]
        },

        {
          #'Payday loan payments' Rules
          heading_code: 'H7.09',
          content_rules: [
            #Q9A9, Q4A1 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-payday-loan-severe"
            },
            #Q9A9, Q4A2 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-payday-loan-temp-worried"
            },
            #Q9A9, Q4A3 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-payday-loan-temp-normal"
            },
            #Q9A9, Q4A4 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-payday-loan-no-change"
            },
          ]
        },

        {
          #'Pawnbroker payments' Rules
          heading_code: 'H7.10',
          content_rules: [
            #Q9A10, Q4A1 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-pawnbroker-severe"
            },
            #Q9A10, Q4A2 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-pawnbroker-temp-worried"
            },
            #Q9A10, Q4A3 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-pawnbroker-temp-normal"
            },
            #Q9A10, Q4A4 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: MASK_ALL + MASK_NONE,
              article: "coronavirus-payday-loan-no-change"
            },
          ]
        },

        {
          #'Payments to family and friends' Rules
          heading_code: 'H7.11',
          content_rules: [
            #Q9A11, Q4A1
            {
              triggers: [
                {q4: 'a1', q9: 'a11'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-friends-family-severe"
            },
            #Q9A11, Q4A2
            {
              triggers: [
                {q4: 'a2', q9: 'a11'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-friends-family-temp-worried"
            },
            #Q9A11, Q4A3
            {
              triggers: [
                {q4: 'a3', q9: 'a11'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-friends-family-temp-normal"
            },
            #Q9A11, Q4A4
            {
              triggers: [
                {q4: 'a4', q9: 'a11'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-friends-family-no-change"
            },
          ]
        },

      ]
    },

    {
      #'Borrowing money' section
      section_code: 'S8',
      heading_rules: [
        {
          #'If you're thinking of borrowing money' Rules
          heading_code: 'H8.1',
          content_rules: [
            #Q11A1, Q4A1
            {
              triggers: [
                {q4: 'a1', q11: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-thinking-of-borrowing-severe"
            },
            #Q11A1, Q4A2
            {
              triggers: [
                {q4: 'a2', q11: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-thinking-of-borrowing-temp-worried"
            },
            #Q11A1, Q4A3
            {
              triggers: [
                {q4: 'a3', q11: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-thinking-of-borrowing-temp-normal"
            },
            #Q11A1, Q4A4
            {
              triggers: [
                {q4: 'a4', q11: 'a1' },
              ],
              mask: MASK_ALL,
              article: "coronavirus-thinking-of-borrowing-no-change"
            },
          ]
        },
      ]
    },

    {
      #'Using pensions, equity and savings' section
      section_code: 'S9',
      heading_rules: [
        {
          #' If you’re thinking about using your pension pot to pay off debts ' Rules
          heading_code: 'H9.1',
          content_rules: [
            #Q12A2
            {
              triggers: [
                {q12: 'a2'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-pensions-debt"
            },
          ]
        },

        {
          #' If you’re thinking about using equity in your home to pay off debts ' Rules
          heading_code: 'H9.2',
          content_rules: [
            #Q12A1 or Q12A3
            {
              triggers: [
                {q12: 'a1', q12: 'a3'},
              ],
              mask: MASK_SOME,
              article: "coronavirus-equity-mortage-debt"
            },
          ]
        },

        {
          #'If you're thinking of using your savings to pay off debts' Rules
          heading_code: 'H9.3',
          content_rules: [
            #Q12A4
            {
              triggers: [
                {q12: 'a4'},
              ],
              mask: MASK_ALL,
              article: "coronavirus-savings-debt"
            },
          ]
        },
      ]
    },

    {
      #'Protecting your future' section
      section_code: 'S10',
      heading_rules: [
        {
          #' If you’re thinking about cancelling insurance ' Rules
          heading_code: 'H10.1',
          content_rules: [
            #Q13A1 or Q13A2
            {
              triggers: [
                {q13: ['a1', 'a2']},
              ],
              mask: MASK_SOME,
              article: "coronavirus-cancelling-insurance"
            },
          ]
        },

      ]
    },

    {
      #'Money worries and mental health' section
      section_code: 'S11',
      heading_rules: [
        {
          #' If money worries are affecting your mental health ' Rules
          heading_code: 'H11.1',
          content_rules: [
            #Q14A1 or Q14A2
            {
              triggers: [
                {q14: ['a1', 'a2']},
              ],
              mask: MASK_SOME,
              article: "coronavirus-mental-health"
            },
          ]
        },

      ]
    },

  ]
end

