module Symbols
  EMPTY = 'EMPTY'

  FLAGS = {
    :'0' => '0',
    :'1' => '1',
    :'2' => '2',
    :'3' => '4',
    :'4' => '8',
    :'5' => '16',
    :'6' => '32',
    :'7' => '64',
    :'8' => '128',
    :'9' => '256',
    :'10'=> '512',
    :'11' => '1024',
    :'12' => '2048',
    :'13' => '4096',
    :'14' => '8192',
    :'15' => '16384',
    :'16' => '32768',
    :'17' => '65536',
    :'18' => '131072',
    :'19' => '262144',
    :'20' => '524288',
    :'21' => '1048576',
    :'22' => '2097152',
    :'23' => '4194304',
    :'24' => '8388608',
    :'25' => '16777216',
    :'26' => '33554432',
    :'27' => '67108864',
    :'28' => '134217728',
    :'29' => '268435456',
    :'30' => '536870912',
    :'31' => '1073741824',
    :'32' => '2147483648'
  }

  QUESTIONS = I18n.translate('c19_diagnostics_tool.questions').map do | question_hash | 
    index = /\d*$/.match(question_hash[:code])[0]
    question_hash[:code].downcase!
    question_hash[:flag] = FLAGS[index.to_sym]
  end


  #TODO get these from the translation files when merged with frotend changes
  #This is each Answer and the position of its flag in the question specific answer bit value
  ANSWER = { 
    EMPTY.to_sym => '0',
    :'A0' => '1',
    :'A1' => '2',
    :'A2' => '3',
    :'A3' => '4',
    :'A4' => '5',
    :'A5' => '6',
    :'A6' => '7',
    :'A7' => '8',
    :'A8' => '9',
    :'A9' => '10',
    :'A10' => '11',
    :'A11' => '12',
    :'A12' => '13',
    :'A13' => '14',
    :'A14' => '15',
    :'A15' => '16',
    :'A16' => '17',
    :'A17' => '18',
    :'A18' => '19',
    :'A19' => '20',
    :'A20' => '21',
    :'A21' => '22',
    :'A22' => '23',
    :'A23' => '24',
    :'A24' => '25',
    :'A25' => '26',
    :'A26' => '27',
    :'A27' => '28',
    :'A28' => '29',
    :'A29' => '30',
    :'A31' => '31',
    :'A31' => '32'  
  }

  #The data representation of the logic that triggers content being displayed
  #Format:
  # <Section Code>: {
  #   <header code>: {
  #     header: <The header to display above any displayed content>
  #     content: [ <this contains the list of content objects that can appear under this header as exampled below>
  #       {
  #         triggers: [
  #           < a list of the QA combinations whose state triggers display of the content >
  #         ],
  #         masks: [
  #           <A list bitmasks that determins whether the triggers turn the header on or off
  #           each list element must contain as many flags as there are triggers and if any one of these masks
  #           matches the triggers then the content will be displayed>
  #         ],
  #         article: <The CMS URL of the content affected >
  #       }
  #     ]
  #   }
  # }
  RESULTS = {
    'S1': {
      text: 'Urgent actions'
      'H1': {
        text: 'Get free Debt advice now (DALT)'
        content: [
          {
            triggers: [ 
              %w[Q0_A1 Q4_A1 Q6_A4, Q6_A5, Q6_A6, Q7_A1 Q7_A2 Q7_A3 Q7_A4 Q7_A5 Q7_A6 Q7_A7 Q7_A8 Q7_A9 Q10_A3]
            ],
            mask: '1',
            article: "corona_virus_urgent_action_england"
          },
          {
            triggers: [ 
              %w[Q0_A2 Q4_A1 Q6_A4, Q6_A5, Q6_A6, Q7_A1 Q7_A2 Q7_A3 Q7_A4 Q7_A5 Q7_A6 Q7_A7 Q7_A8 Q7_A9 Q10_A3]
            ],
            mask: '1',
            article: "coronavirus-debt-advice-ni"
          },
          {
            triggers: [ 
              %w[Q0_A3 Q4_A1 Q6_A4, Q6_A5, Q6_A6, Q7_A1 Q7_A2 Q7_A3 Q7_A4 Q7_A5 Q7_A6 Q7_A7 Q7_A8 Q7_A9 Q10_A3]
            ],
            mask: '1',
            article: "coronavirus-debt-advice-scotland"
          },
          {
            triggers: [ 
              %w[Q0_A4 Q4_A1 Q6_A4, Q6_A5, Q6_A6, Q7_A1 Q7_A2 Q7_A3 Q7_A4 Q7_A5 Q7_A6 Q7_A7 Q7_A8 Q7_A9 Q10_A3]
            ],
            mask: '1',
            article: "coronavirus-debt-advice-wales"
          }
        ]
      }
    }
  }
end

