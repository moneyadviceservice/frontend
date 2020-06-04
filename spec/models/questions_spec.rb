RSpec.describe Questions, type: :model do
  include Symbols

  let(:countries) { %w[england ni wales scotland] }
  context 'Urgent action' do
    let(:urgent_action_section_code) { 'S1' }
#TODO: Refactor tests so that the report reads better as they continue to reuse the common logic:w
    #Not goo to loop through all countries like this from a failure reporting perspective
    describe  'StepChange content' do
      let(:urgent_action_heading_code) { 'H2' }

      it "should only display the one country specific urgent action section containing StepChange content" do
        countries.each do | country |
          model = build("answers_requiring_urgent_#{country}_stepchange_action".to_sym)
          results = model.results
          expect(results.length).to eql 1
          expect(results[0])
            .to include(
              {
                "section_code"=>"S1",
                "headings"=>[
                  {
                    "heading_code"=>"H2",
                    "content"=> ["coronavirus-stepchange-debt-#{country}"]
                  }
                ]
              }
          )
        end
      end
    end

    describe  'get free debt advice' do
      let(:urgent_action_heading_code) { 'H1' }

      it "should only display the one country specific urgent action section containing free debt advice  content" do
        countries.each do | country |
          model = build("answers_requiring_urgent_#{country}_action".to_sym)
          results = model.results
          expect(results.length).to eql 1
          expect(results[0])
            .to include(
              {
                "section_code"=>"S1",
                "headings"=>[
                  {
                    "heading_code"=>"H1",
                    "content"=> ["coronavirus-debt-advice-#{country}"]
                  }
                ]
              }
          )
        end
      end
    end
  end
end
