module MoneyHelper::Symbols
  FLAGS = {
    :'1' => '1',
    :'2' => '2',
    :'3' => '4',
    :'4' => '8',
    :'5' => '16',
    :'6' => '32',
    :'7' => '64',
    :'8' => '128',
    :'9' => '256',
    :'10' => '512',
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

  #TODO get these from the translation files when merged with frotend changes
  #This is each Question and the position of its flag in the question specific bits value
  QUESTIONS = { 
    :'Q1' => '1',
    :'Q2' => '2',
    :'Q3' => '3',
    :'Q4' => '4',
    :'Q5' => '5',
    :'Q6' => '6',
    :'Q7' => '7',
    :'Q8' => '8',
    :'Q9' => '9',
    :'Q10' => '10',
    :'Q11' => '11',
    :'Q12' => '12',
    :'Q13' => '13',
    :'Q14' => '14',
    :'Q15' => '15',
    :'Q16' => '16',
    :'Q17' => '17',
    :'Q18' => '18',
    :'Q19' => '19',
    :'Q20' => '20',
    :'Q21' => '21',
    :'Q22' => '22',
    :'Q23' => '23',
    :'Q24' => '24',
    :'Q25' => '25',
    :'Q26' => '26',
    :'Q27' => '27',
    :'Q28' => '28',
    :'Q29' => '29',
    :'Q30' => '30',
    :'Q31' => '31',
    :'Q32' => '32'  
  }
  
  
  #TODO get these from the translation files when merged with frotend changes
  #This is each Answer and the position of its flag in the question specific answer bit value
  ANSWER = { 
    :'A1' => '1',
    :'A2' => '2',
    :'A3' => '3',
    :'A4' => '4',
    :'A5' => '5',
    :'A6' => '6',
    :'A7' => '7',
    :'A8' => '8',
    :'A9' => '9',
    :'A10' => '10',
    :'A11' => '11',
    :'A12' => '12',
    :'A13' => '13',
    :'A14' => '14',
    :'A15' => '15',
    :'A16' => '16',
    :'A17' => '17',
    :'A18' => '18',
    :'A19' => '19',
    :'A20' => '20',
    :'A21' => '21',
    :'A22' => '22',
    :'A23' => '23',
    :'A24' => '24',
    :'A25' => '25',
    :'A26' => '26',
    :'A27' => '27',
    :'A28' => '28',
    :'A29' => '29',
    :'A30' => '30',
    :'A31' => '31',
    :'A32' => '32'  
  }

  HEADINGS_AND_CTAS = {
    :'H1' => { 
      touch_points: %w[ Q1_A1 Q5_A5 ],
      activation_mask: '2'
    }
end

