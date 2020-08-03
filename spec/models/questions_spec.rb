RSpec.describe Questions, type: :model do
  include Symbols

  shared_examples 'valid content' do
    it 'displays the appropriate heading and content' do
      allow_any_instance_of(Questions).to receive(:cms_content) {|me, slug| "#{ slug }"}
      results =  model.results
      expect(results).to include({
        "section_code" => section_code,
        "headings" => array_including(
          hash_including({
            "heading_code"=>heading_code,
            "content"=>hash_including({url: "#{url}"})
          })
        )
      })
    end
  end

  shared_examples 'country specific content' do
    let(:url) { "coronavirus-#{content_prefix}" + ( country.empty? ? '' :  "-#{country}" )}
    let(:model) { build("#{section}_#{content_prefix}".gsub('-', '_').to_sym, target_country: country.empty? ? 'all' : country) }

    include_examples 'valid content'
  end

  shared_examples 'urgent action country specific' do
    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      describe  'DebtLine' do
        let(:heading_code) { 'H3' }
        let(:content_prefix) {'self-employed-debt-advice'}
        let(:content_url) {"coronavirus-#{content_prefix}-#{country}"}

        include_examples 'country specific content' do
        end
      end

      # describe  'StepChange' do
      #   let(:heading_code) { 'H2' }
      #   let(:content_prefix) {'stepchange-debt'}
      #   let(:corona_specific_content) {true}

      #   include_examples 'country specific content' do
      #   end
      # end

    end
  end

  shared_examples 'urgent action uk' do
    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      describe  'DebtLine' do
        let(:heading_code) { 'H3' }
        let(:content_prefix) {'self-employed-debt-advice'}
        let(:content_url) {"coronavirus-#{content_prefix}"}

        include_examples 'uk specific content' do
        end
      end
    end
  end


  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

  context 'Rule tests' do
    context 'Urgent action' do
      let(:section) {'urgent_action'}
      let(:section_code) { 'S1' }

      ['england', 'wales', 'scotland', 'ni'].each do |cntry|
        describe  "free debt advice #{cntry}" do
          let(:country) {cntry}
          let(:heading_code) { 'H1' }
          let(:content_prefix) {"debt-advice"}

          include_examples 'country specific content'
        end
      end

      #[['england', 'wales', 'scotland']].each do |region| do
          #let(:country) {''}
          #let(:heading_code) { 'H1' }
          #let(:content_prefix) {"debt-advice"}

          #include_examples 'country specific content'
      #end



    end

  end
end
