module Symbols
  FLAGS = {
    :'0' => '1',
    :'1' => '2',
    :'2' => '4',
    :'3' => '8',
    :'4' => '16',
    :'5' => '32',
    :'6' => '64',
    :'7' => '128',
    :'8' => '256',
    :'9' => '512',
    :'10' => '1024',
    :'11' => '2048',
    :'12' => '4096',
    :'13' => '8192',
    :'14' => '16384',
    :'15' => '32768',
    :'16' => '65536',
    :'17' => '131072',
    :'18' => '262144',
    :'19' => '524288',
    :'20' => '1048576',
    :'21' => '2097152',
    :'22' => '4194304',
    :'23' => '8388608',
    :'24' => '16777216',
    :'25' => '33554432',
    :'26' => '67108864',
    :'27' => '134217728',
    :'28' => '268435456',
    :'29' => '536870912',
    :'30' => '1073741824',
    :'31' => '2147483648'
  }

  #TODO get these from the translation files when merged with frotend changes
  #This is each Question and the position of its flag in the question specific bits value
  QUESTIONS = { 
    :'Q0' => '1',
    :'Q1' => '2',
    :'Q2' => '3',
    :'Q3' => '4',
    :'Q4' => '5',
    :'Q5' => '6',
    :'Q6' => '7',
    :'Q7' => '8',
    :'Q8' => '9',
    :'Q9' => '10',
    :'Q10' => '11',
    :'Q11' => '12',
    :'Q12' => '13',
    :'Q13' => '14',
    :'Q14' => '15'
  }


  #TODO get these from the translation files when merged with frotend changes
  #This is each Answer and the position of its flag in the question specific answer bit value
  ANSWER = { 
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

