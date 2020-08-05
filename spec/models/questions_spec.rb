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

  context 'Rule test: ' do
    context 'Urgent action' do
      let(:section_code) { 'S1' }

      ['england', 'wales', 'scotland', 'ni'].each do |country|
        describe  "free debt advice #{country}" do
          let(:heading_code) { 'H1' }
          let(:content_prefix) {"debt-advice"}
          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: [ country ]) }
          let(:url) { "coronavirus-#{content_prefix}-#{country}" }

          include_examples 'valid content'
        end
      end

      [['england', 'wales', 'scotland']].each do |region|
        describe  "free debt advice #{region}" do
          let(:heading_code) { 'H2' }
          let(:content_prefix) {"self-employed-debt-advice"}
          let(:model) { build("#{section_code}_#{heading_code}_stepchange_redirect_to_#{content_prefix}".gsub('-', '_').to_sym, target_region: region) }
          let(:url) { "coronavirus-#{content_prefix}" }

          include_examples 'valid content'
        end
      end

      ['ni'].each do |country|
        describe  "free debt advice #{country}" do
          let(:heading_code) { 'H2' }
          let(:content_prefix) {"self-employed-debt-advice"}
          let(:model) { build("#{section_code}_#{heading_code}_stepchange_redirect_to_#{content_prefix}_#{country}".gsub('-', '_').to_sym, target_region: [ country ]) }
          let(:url) { "coronavirus-#{content_prefix}-#{country}" }
          include_examples 'valid content'
        end
      end

      #All other debt advice redirected to stepchange england
      [[ 'england', 'wales', 'scotland', 'ni' ]].each do |region|
        describe  "free debt advice #{region} england redirect" do
          let(:heading_code) { 'H2' }
          let(:content_prefix) {"stepchange-debt"}
          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}_england".gsub('-', '_').to_sym, target_region: region) }
          let(:url) { "coronavirus-#{content_prefix}-england" }
          include_examples 'valid content'
        end
      end

      #self employed debt advice
      [['england', 'wales', 'scotland']].each do |region|
        describe  "Self employed debt advice #{region}" do
          let(:heading_code) { 'H3' }
          let(:content_prefix) {"self-employed-debt-advice"}
          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: region) }
          let(:url) { "coronavirus-#{content_prefix}" }

          include_examples 'valid content'
        end
      end

      ['ni'].each do |country|
        describe  "Self employed debt advice #{country}" do
          let(:heading_code) { 'H3' }
          let(:content_prefix) {"self-employed-debt-advice"}
          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: [ country ] ) }
          let(:url) { "coronavirus-#{content_prefix}-#{country}" }

          include_examples 'valid content'
        end
      end

      #Pension content rule tests
      [['england', 'wales', 'scotland', 'ni']].each do |region|
        describe  "Pension advice  #{region}" do
          let(:heading_code) { 'H4' }
          let(:content_prefix) {"pension-advice"}
          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: region) }
          let(:url) { "urgent-#{content_prefix}" }

          include_examples 'valid content'
        end
      end
    end

  end
end
