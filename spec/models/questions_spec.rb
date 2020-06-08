RSpec.describe Questions, type: :model do
  include Symbols


  shared_examples 'content' do
    let(:model) { build("#{section}_#{country}_#{content_prefix}".gsub('-', '_').to_sym) }
    let(:results) { model.results }

    it 'displays at least one section' do
      expect(results.length).to eql 1
    end

    it 'displays appropriate content' do
      expect(results[0])
        .to include(
          {
            "section_code"=>"#{section_code}",
            "headings"=>[
              {
                "heading_code"=>"#{heading_code}",
                "content"=> ["coronavirus-#{content_prefix}-#{country}"]
              }
            ]
          }
      )
    end
  end

  shared_examples 'urgent action' do
    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      describe  'free debt advice' do
        let(:heading_code) { 'H1' }
        let(:content_prefix) {"debt-advice"}

        include_examples 'content' do
        end
      end

      skip  'StepChange' do
        let(:heading_code) { 'H2' }
        let(:content_prefix) {'stepchange-debt'}

        include_examples 'content' do
        end
      end

      skip  'DebtLine' do
        let(:heading_code) { 'H3' }
        let(:content_prefix) {'self-employed-debt-advice'}

        include_examples 'content' do
        end
      end
    end
  end

  #%w[england northern_ireland wales scotland].each do | country |
  context 'England' do
    let(:country) { 'england' }
    include_examples 'urgent action'
  end

  context 'Scotland' do
    let(:country) { 'scotland' }
    include_examples 'urgent action'
  end

  context 'Northern Ireland' do
    let(:country) { 'ni' }
    include_examples 'urgent action'
  end

  context 'Scotland' do
    let(:country) { 'wales' }
    include_examples 'urgent action'
  end

end
