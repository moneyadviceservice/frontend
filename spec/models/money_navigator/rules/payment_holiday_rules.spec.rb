
RSpec.shared_examples 'payments common' do 
          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".gsub('-', '_').to_sym, target_region: region ) }
          let(:url) { "coronavirus-#{content_prefix}" }
end

RSpec.describe Questions, type: :model do
  include ::Symbols

  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

  context 'Rule test: ' do
    context 'Payment Holidays' do
      let(:section_code) { 'S2' }

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Mortgage" do
          let(:heading_code) { 'H1' }

          describe  "severe" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-mortgage-payment-severe"}

            include_examples 'payments common'
            include_examples 'valid content'
          end

          describe  "temp worried" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-mortgage-payment-temp-worried"}

            include_examples 'payments common'
            include_examples 'valid content'
          end

          describe  "temp normal" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-mortgage-payment-temp-normal"}

            include_examples 'payments common'
            include_examples 'valid content'
          end

          describe  "temp no change" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-mortgage-payment-no-change"}

            include_examples 'payments common'
            include_examples 'valid content'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Personal loan #{rgn}" do
          let(:heading_code) { 'H2' }

          describe  "severe" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-personal-loan-severe"}

            include_examples 'payments common'
            include_examples 'valid content'
          end

          describe  "temp worried" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-personal-loan-temp-worried"}

            include_examples 'payments common'
            include_examples 'valid content'
          end

          describe  "temp normal" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-personal-loan-temp-normal"}

            include_examples 'payments common'
            include_examples 'valid content'
          end

          describe  "temp no change" do
            let(:region) { rgn }
            let(:content_prefix) {"holiday-personal-loan-no-change"}

            include_examples 'payments common'
            include_examples 'valid content'
          end
        end

      end

    end
  end
end
