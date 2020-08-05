include Symbols
  #TODO consider moving these methods into a module if needed for other fixtures.
  #Also to prevent polution of the global namespace (though not sure that's important given the way Factorybot is coded)
  def randomn_answers(answers, allow_empty)
    choice = answers.sample(rand(1..answers.length)) if  !allow_empty
    choice = answers.sample(rand(0..answers.length)) if  allow_empty
    choice
  end


  def answers_with_entropy(question_code, mandatory_set, optional_set)
    #All questions can be randomnly spliced in if the optional set is nil.
    #If it is an empty array then no other answers will be randomnly spliced in
    answers = QUESTIONS_HASH[question_code][:responses]
    if optional_set.nil?
      if(answers[0][:text] == "Yes") && (answers[0].length == 2)
        optional = ['a' + rand(1..2).to_s ]
        mandatory_set = []
      else
        optional = randomn_answers((1..QUESTIONS_HASH[question_code][:responses].length).to_a.map{|index| "a#{index}"}, true)
      end
    else
      optional = randomn_answers(optional_set, false) unless optional_set.empty?
    end

    #A nill mandatory_set means nothing.
    #An empty mandatory set means nothing is mandatory (i.e. the question can be left unanswerd)
    mandated = randomn_answers(mandatory_set, false) unless mandatory_set.empty?
    mandated = [] if mandatory_set.empty?

    #If the optional set is given then we can only select randomnly from it
    optional = randomn_answers(optional_set, true) unless optional_set.nil?
    answers = mandated | optional
    answers = answers[0] if answers.length == 1
    answers
  end

