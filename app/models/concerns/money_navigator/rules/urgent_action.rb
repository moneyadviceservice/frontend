class MoneyNavigator::Rules::UrgentAction
  include MoneyNavigator::Constants

  def self.all
    {
      #'Urgent Actions' section
      section_code: 'S1',
      heading_rules: [

        {
          #Get Free debt advice now' Rules
          #Any of these Q4A1, Q6A6, Q7A1-A9, Q10A3 PLUS the regional variation
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                {q0:'a1'},
                {q4:'a1', q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:'a3'},
                {q1:'a2'},
              ],
              mask: [ MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE  ],
              article: "coronavirus-debt-advice-england"
            },
            {
              triggers: [
                {q0:'a2'},
                {q4:'a1', q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:'a3'},
                {q1:'a2'},
              ],
              mask: [ MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE  ],
              article: "coronavirus-debt-advice-ni"
            },
            {
              triggers: [
                {q0:'a3'},
                {q4:'a1', q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:'a3'},
                {q1:'a2'},
              ],
              mask: [ MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE  ],
              article: "coronavirus-debt-advice-scotland"
            },
            {
              triggers: [
                {q0:'a4'},
                {q4:'a1', q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:'a3'},
                {q1:'a2'},
              ],
              mask: [ MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE  ],
              article: "coronavirus-debt-advice-wales"
            }
          ]
        },

        {
          #'Pre Stepchange temporary ' heading rules
          #NB. The proper stepchange rules have been commented out below.
          #these should be deleted and the stepchange ones uncommented when stepchange is available
          heading_code: 'H2',
          content_rules: [
            #Show if Q1A2 plus Q0A1 or Q0A3 or Q0A4 plus any of Q4A2, Q4A3, Q6A4, Q6A5, Q9A1-A11, Q10A1 BUT NOT IF HAVE ALSO SELECTED Q4A4, Q4A1, Q6A6, Q7A1-A9, Q10A3
            {
              triggers: [
                {q0:['a1', 'a3', 'a4']},
                {q1:['a2']},
                {q4:['a2', 'a3'], q6:['a4', 'a5'], q9:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11'], q10:['a1']},
                {q4:['a4', 'a1'], q6: ['a6'], q7: ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10: ['a3']},
              ],
              mask: [ MASK_SOME + MASK_ALL + MASK_SOME + MASK_NONE,
                      MASK_SOME + MASK_ALL + MASK_ALL + MASK_NONE,
                      MASK_ALL + MASK_ALL + MASK_SOME + MASK_NONE,
                      MASK_ALL + MASK_ALL + MASK_ALL + MASK_NONE],
                      article: "coronavirus-self-employed-debt-advice"
            },
            #Show if Q1A2 (self employed flag) plus Q0A2, plus any of these Q3A1, Q4A2, Q4A3, Q6A4, Q6A5, Q9A1-A11, Q10A1  BUT NOT IF HAVE ALSO SELECTED Q4A1, Q4A4, Q6A6, Q7A1-A9, Q10A3
            {
              triggers: [
                {q0:['a2']},
                {q1:['a2']},
                {q3: ['a1'], q4:['a2', 'a3'], q6:['a4', 'a5'], q9:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11'], q10:['a1']},
                {q4:['a4', 'a1'], q6: ['a6'], q7: ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10: ['a3']},
              ],
              mask: [ MASK_SOME + MASK_ALL + MASK_SOME + MASK_NONE,
                      MASK_SOME + MASK_ALL + MASK_ALL + MASK_NONE,
                      MASK_ALL + MASK_ALL + MASK_SOME + MASK_NONE,
                      MASK_ALL + MASK_ALL + MASK_ALL + MASK_NONE],
                      article: "coronavirus-self-employed-debt-advice-ni"
            },
            #All of these Q3A1, Q4A2 OR Q4A3, Q6A4 OR Q6A5, Q9A1-A11, Q10A1, BUT NOT IF HAVE ALSO SELECTED Q4A4, Q4A1, Q6A6, Q7A1-A9, Q10A3
            #Show if any of these Q4A2, Q4A3, Q6A4, Q6A5, Q9A1-A11, Q10A1  BUT NOT IF HAVE ALSO SELECTED Q4A4, Q4A1, Q6A6, Q7A1-A9, Q10A3
            {
              triggers: [
                {q3:['a1', 'a3']},
                {q4:['a2', 'a3']},
                {q6:['a4', 'a5']},
                {q9:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11']},
                {q10:['a1']},
                {q1: 'a2', q4:['a1', 'a4'], q6: ['a6'], q7: ['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10: ['a3']},
              ],
              mask: [
                MASK_SOME + MASK_SOME + MASK_SOME + MASK_SOME + MASK_ALL + MASK_NONE,
                MASK_SOME + MASK_SOME + MASK_SOME + MASK_ALL + MASK_ALL + MASK_NONE
              ],
              article: "coronavirus-stepchange-debt-england"
            },
          ]
        },

        {
          #'SELF EMPLOYED DEBT ADVICE Contact Business Debtline for England' heading rules
          heading_code: 'H3',
          content_rules: [
            {
              triggers: [
                {q0:['a1', 'a3', 'a4']},
                {q1:'a2'},
                {q3:['a2'], q4:['a1'], q5:['a3'], q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:['a3']},
              ],
              mask: [ MASK_SOME + MASK_ALL + MASK_SOME,  MASK_ALL + MASK_ALL + MASK_SOME,  MASK_SOME + MASK_ALL + MASK_ALL ,  MASK_ALL + MASK_ALL + MASK_ALL ],
              article: "coronavirus-self-employed-debt-advice"
            },

            {
              triggers: [
                {q0:['a2']},
                {q1:'a2'},
                {q3:['a2'], q4:['a1'], q5:['a3'], q6:['a6'], q7:['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9'], q10:['a3']},
              ],
              mask: [ MASK_SOME + MASK_ALL + MASK_SOME,  MASK_ALL + MASK_ALL + MASK_SOME,  MASK_SOME + MASK_ALL + MASK_ALL ,  MASK_ALL + MASK_ALL + MASK_ALL ],
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
              mask: [ MASK_ALL ],
              article: "urgent-pension-advice"
            },

          ]
        },

        {
          #'Mental Health CTA' heading rules
          heading_code: 'H5',
          content_rules: [
            {
              triggers: [
                {q0:['a1', 'a2', 'a3']},
                {q14:['a3']}
              ],
              mask: [ MASK_SOME + MASK_ALL ],
              article: "coronavirus-help-mental-health-sometimes"
            },

            {
              triggers: [
                {q0:['a4']},
                {q14:['a3']}
              ],
              mask: [ MASK_ALL + MASK_ALL ],
              article: "coronavirus-help-mental-health-sometimes-wales"
            },

            {
              triggers: [
                {q0:['a1']},
                {q14:['a1']}
              ],
              mask: [ MASK_ALL + MASK_ALL ],
              article: "coronavirus-help-mental-health-england"
            },

            {
              triggers: [
                {q0:['a2']},
                {q14:['a1']}
              ],
              mask: [ MASK_ALL + MASK_ALL ],
              article: "coronavirus-help-mental-health-ni"
            },

            {
              triggers: [
                {q0:['a3']},
                {q14:['a1']}
              ],
              mask: [ MASK_ALL + MASK_ALL ],
              article: "coronavirus-help-mental-health-scotland"
            },

            {
              triggers: [
                {q0:['a4']},
                {q14:['a1']}
              ],
              mask: [ MASK_ALL + MASK_ALL ],
              article: "coronavirus-help-mental-health-wales"
            },
          ]
        }
      ]
    }
  end
end
