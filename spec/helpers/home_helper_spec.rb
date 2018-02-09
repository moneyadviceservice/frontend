RSpec.describe HomeHelper, type: :helper do
  describe '#leader_text' do
    context 'when request is made for "student" text on large screen' do
      it 'should not be empty' do
        expect(helper.leader_text('student', 'mq_l', 5, 6, 90)).not_to be_empty
      end

      it 'returns the expected HTML snippet' do
x = %Q(\
<text text-anchor='middle' x=5 y=6 transform='rotate(90 5 6)'>\
  <tspan dx=\"0\" dy=\"-10.5\">I have a</tspan><tspan dx=\"-62\" dy=\"21\">student loan</tspan>\
</text>\
)

        expect(helper.leader_text('student', 'mq_l', 5, 6, 90)).to eq(x)
      end
    end
  end
end
