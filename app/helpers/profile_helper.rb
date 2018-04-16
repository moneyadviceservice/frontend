module ProfileHelper
  APOSTROPHE = '’'.freeze

  def singular_noun_possessive(noun)
    noun + (noun[-1] == 's' ? APOSTROPHE : APOSTROPHE + 's')
  end
end
