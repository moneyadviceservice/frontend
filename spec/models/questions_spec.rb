RSpec.describe Questions, type: :model do
  include Symbols

  context 'Urgent action' do
    let(:urgent_action_section_code) { 'S1' }

    # describe 'submissions requiring StepChange intervention' do
    #   let(:urgent_action_heading_code) { 'H2' }
    #   let(:model) { build(:answers_requiring_urgent_england_stepchange_action) }

    #   it 'should only display the one urgent StepChange action section containing only England content' do
    #     results = model.results
    #     expect(results.length).to eql 1
    #     expect(results[0])
    #       .to include(
    #                   {
    #                     "section_code"=>"S1",
    #                     "headings"=>[
    #                       {
    #                         "heading_code"=>"H2",
    #                         "content"=> ["coronavirus-stepchange-debt-england"]
    #                       }
    #                     ]
    #                   }
    #                  )
    #   end

    # end

    # describe 'submissions from england' do
    #   let(:urgent_action_heading_code) { 'H1' }
    #   let(:model) { build(:answers_requiring_urgent_england_action) }

    #   it 'should only display the one urgent action section containing only England content' do
    #     results = model.results
    #     expect(results.length).to eq 1
    #     expect(results[0])
    #       .to include(
    #                   {
    #                     "section_code"=>"S1",
    #                     "headings"=>[
    #                       {
    #                         "heading_code"=>"H1",
    #                         "content"=> ["coronavirus-debt-advice-england"]
    #                       }
    #                     ]
    #                   }
    #                  )
    #   end

    # end

    # describe 'submissions from Wales' do
    #   let(:model) { build(:answers_requiring_urgent_wales_action) }

    #   it 'should only display the one urgent action section containing only Wales content' do
    #     results = model.results
    #     expect(results.length).to eq 1
    #     expect(results[0])
    #       .to include(
    #                   {
    #                     "section_code"=>"S1",
    #                     "headings"=>[
    #                       {
    #                         "heading_code"=>"H1",
    #                         "content"=> ["coronavirus-debt-advice-wales"]
    #                       }
    #                     ]
    #                   }
    #                  )
    #   end

    # end

    # describe 'submissions from Northern Ireland' do
    #   let(:model) { build(:answers_requiring_urgent_northern_ireland_action) }

    #   it 'should only display the one urgent action section containing only Northern Ireland content' do
    #     results = model.results
    #     expect(results.length).to eq 1
    #     expect(results[0])
    #       .to include(
    #                   {
    #                     "section_code"=>"S1",
    #                     "headings"=>[
    #                       {
    #                         "heading_code"=>"H1",
    #                         "content"=> ["coronavirus-debt-advice-ni"]
    #                       }
    #                     ]
    #                   }
    #                  )
    #   end

    # end

    # describe 'submissions from Scotland' do
    #   let(:model) { build(:answers_requiring_urgent_scotland_action) }

    #   it 'should only display the one urgent action section containing only Scotland content' do
    #     results = model.results
    #     expect(results.length).to eq 1
    #     expect(results[0])
    #       .to include(
    #                   {
    #                     "section_code"=>"S1",
    #                     "headings"=>[
    #                       {
    #                         "heading_code"=>"H1",
    #                         "content"=> ["coronavirus-debt-advice-scotland"]
    #                       }
    #                     ]
    #                   }
    #                  )
    #   end

    # end
  end
end
