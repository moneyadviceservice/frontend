
  RSpec.describe Questions, type: :model do
    include ::Symbols

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
