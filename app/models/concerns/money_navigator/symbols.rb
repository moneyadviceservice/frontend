module MoneyNavigator::Symbols
  # IMPORTANT: #We must enforce the hard limits of the system
  #
  # The masking only works if the question and answer flags are the same width
  # This means there are the following hard limits in the system:
  #- No more than FLAG_SIZE questions can be asked by the system
  #- No Question can have more than FLAG_SIZE answers
  #
  # NB:
  #- FLAG_SIZE represents the larger of [total number of questions] and [maximum number of answers per question]
  #- The output of all computed/created flag values must be validated by validate_flag(flag)  method
  #- Use FLAG_FORMAT to create bit strings from integers in line with FLAG_SIZE
  #
  # Changing the value of FLAG_SIZE is therefore enough should you require the system to handle
  # a different number of questions/answers in line with the above notes
  FLAG_SIZE = 16
  # The flag is a zero left padded FLAG_SIZE long bit long binarry string
  FLAG_FORMAT = "%0#{FLAG_SIZE}i".freeze
  FULL_FLAG_FORMAT = "%0#{FLAG_SIZE * FLAG_SIZE * 2}i".freeze
  def self.validate_flag(flag)
    # Can't really process anything if flags exist that we can not handle. Only alternative is to BOMB out
    raise "Flag #{qn_hash[:flag]} for question #{qn_hash[:code]} (index: #{index}) has size: #{qn_hash[:flag].length}. Expected size: #{FLAG_SIZE}" if flag.length != FLAG_SIZE
  end

  EMPTY = 'EMPTY'.freeze
  ALL = 'ALL'.freeze

  # Set up the flags reference hash/lookup-table that will be used by the system
  FLAGS = HashWithIndifferentAccess.new
  FLAGS[EMPTY] = FLAG_FORMAT % '0'
  FLAGS[ALL] = '1' * FLAG_SIZE
  (0..FLAG_SIZE).to_a.each { |index| FLAGS[index.to_s] = FLAG_FORMAT % (2**index).to_s(2) }

  # setup the question/answer hashes
  #- QUESTIONS: An array of all the questions from the yml file enriched with flag information and with the code standadised to lowercase
  #- QUESTIONS_HASH: hash of all the questions keyed on the question code
  #- ANSWERS_HASH: hash containing all possible answer codes (keyed by code) and enriched with the respective flag information
  QUESTIONS_HASH = HashWithIndifferentAccess.new
  ANSWERS_HASH = HashWithIndifferentAccess.new

  # Enrich a given question hashbag with flag information and downcased codes
  # As a sideeffect the bag is updated into the QUESTIONS_HASH for faster code based lookup
  def self.enrich_question(qn_hash)
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
    qn_hash[:responses].sort! { |r1, r2| r1[:sort_order].to_i <=> r2[:sort_order].to_i }

    qn_hash
  end

  QUESTIONS = I18n.translate('money_navigator_tool.questions')
                  .map { |qn_hash| enrich_question(qn_hash) }
                  .sort { |q1, q2| q1[:sort_order].to_i <=> q2[:sort_order].to_i }

  ANSWERS_HASH['EMPTY'] = { code: EMPTY, flag: FLAGS[EMPTY] }
end
