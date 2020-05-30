module Symbols
  EMPTY = 'EMPTY'

  FLAGS = {
    :'0' => 0,
    :'1' => 1,
    :'2' => 2,
    :'3' => 4,
    :'4' => 8,
    :'5' => 16,
    :'6' => 32,
    :'7' => 64,
    :'8' => 128,
    :'9' => 256,
    :'10'=> 512,
    :'11' => 1024,
    :'12' => 2048,
    :'13' => 4096,
    :'14' => 8192,
    :'15' => 16384,
    :'16' => 32768,
    :'17' => 65536,
    :'18' => 131072,
    :'19' => 262144,
    :'20' => 524288,
    :'21' => 1048576,
    :'22' => 2097152,
    :'23' => 4194304,
    :'24' => 8388608,
    :'25' => 16777216,
    :'26' => 33554432,
    :'27' => 67108864,
    :'28' => 134217728,
    :'29' => 268435456,
    :'30' => 536870912,
    :'31' => 1073741824,
    :'32' => 2147483648
  }

  QUESTIONS_HASH = HashWithIndifferentAccess.new
  ANSWERS_HASH = HashWithIndifferentAccess.new

  QUESTIONS = I18n.translate('c19_diagnostics_tool.questions').map do | qn_hash |
    index = /\d*$/.match(qn_hash[:code])[0]
    qn_hash[:code].downcase!
    qn_hash[:flag] = FLAGS[index.to_sym].to_s(2)
    QUESTIONS_HASH[qn_hash[:code]] = qn_hash
    qn_hash[:responses].each do |resp|
      index = /\d*$/.match(resp[:code])[0]
      ANSWERS_HASH[resp[:code].downcase] = index
    end
  end



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
  # TODO: All/most of this file needs to move into the translation files. Only the rules need remain here.
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
      ]
    }
  ]
end

