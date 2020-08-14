
  RSpec.describe Questions, type: :model do
    include MoneyNavigator::Symbols

    #TODO: These are all positive tests. need to add negative tests
    #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

    context 'Rule test: ' do
      context 'Urgent action' do
        let(:section_code) { 'S1' }

        ['england', 'wales', 'scotland', 'ni'].each do |country|
          describe  "free debt advice #{country}" do
            let(:heading_code) { 'H1' }
            let(:region) { country }
            let(:content_prefix) {"debt-advice"}

            include_examples 'nationally valid content for regional rule'
          end
        end

        [['england', 'wales', 'scotland']].each do |region|
          describe  "free debt advice #{region}" do
            let(:heading_code) { 'H2' }
            let(:region) { region }
            let(:content_prefix) {"self-employed-debt-advice"}

            include_examples 'regionally valid content for regional rule'
          end
        end

        [ 'ni' ].each do |country|
          describe  "free debt advice #{country}" do
            let(:heading_code) { 'H2' }
            let(:region) { country }
            let(:content_prefix) {"self-employed-debt-advice"}

            include_examples 'nationally valid content for regional rule'
          end
        end

        #All other debt advice redirected to stepchange england
        [[ 'england', 'wales', 'scotland', 'ni' ]].each do |region|
          describe  "free debt advice #{region} england redirect" do
            let(:heading_code) { 'H2' }
            let(:region) { 'england' }
            let(:content_prefix) {"stepchange-debt"}

            include_examples 'nationally valid content for national rule'
          end
        end

        #self employed debt advice
        [['england', 'wales', 'scotland']].each do |region|
          describe  "Self employed debt advice #{region}" do
            let(:heading_code) { 'H3' }
            let(:region) { region }
            let(:content_prefix) {"self-employed-debt-advice"}

            include_examples 'regionally valid content for regional rule'
          end
        end

        ['ni'].each do |country|
          describe  "Self employed debt advice #{country}" do
            let(:heading_code) { 'H3' }
            let(:region) { country }
            let(:content_prefix) {"self-employed-debt-advice"}

            include_examples 'nationally valid content for regional rule'
          end
        end

        #Pension content rule tests
        [['england', 'wales', 'scotland', 'ni']].each do |region|
          describe  "Pension advice  #{region}" do
            let(:heading_code) { 'H4' }
            let(:region) { region }
            let(:content_prefix) {"urgent-pension-advice"}

            let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: region ) }
            let(:url) { "#{content_prefix}" }

            include_examples 'valid content'
          end
        end
      end

    end
  end
