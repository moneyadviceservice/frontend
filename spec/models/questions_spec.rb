RSpec.describe Questions, type: :model do
  #subject { build(:answers_requiring_urgent_england_action) }

  it '(returns results prompting for urgent england action' do 
    expect(subject.results(england_seek_advice_answers)).to eq 'H1'
  end

  def england_seek_advice_answers
      {"q0"=>"a3",
   "q1"=>"a1",
   "q2"=>"a2",
   "q3"=>"a1",
   "q4"=>"a1",
   "q5"=>"a1",
   "q6"=>["a1, a6"],
   "q7"=>["a4"],
   "q8"=>["a2"],
   "q9"=>["a10"],
   "q10"=>"a3",
   "q11"=>"a2",
   "q12"=>["a1"],
   "q13"=>"a2",
   "q14"=>"a1"}
  end
end
