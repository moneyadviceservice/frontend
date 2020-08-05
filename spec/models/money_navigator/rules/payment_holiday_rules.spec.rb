
  RSpec.describe Questions, type: :model do
    include ::Symbols

    #TODO: These are all positive tests. need to add negative tests
    #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

    context 'Rule test: ' do
      context 'Payment Holidays' do
        let(:section_code) { 'S2' }

        [[ 'england', 'wales', 'scotland', 'ni'] ].each do |region|
          describe  "free debt advice #{region}" do
            let(:heading_code) { 'H1' }
            let(:content_prefix) {"holiday-mortgage-payment-severe"}
            let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: region ) }
            let(:url) { "coronavirus-#{content_prefix}" }

            include_examples 'valid content'
          end
        end

      end

    end
  end
