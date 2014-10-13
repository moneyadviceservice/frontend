module ProfileHelper

  APOSTROPHE = '’'

  def singular_noun_possessive(noun)
    noun + ('s' == noun[-1] ? APOSTROPHE : APOSTROPHE + 's')
  end
end
