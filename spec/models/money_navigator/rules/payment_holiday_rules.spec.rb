
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
        let(:heading_code) { 'H1' }

        describe  "Mortgage severe #{rgn}" do
          let(:region) { rgn }
          let(:content_prefix) {"holiday-mortgage-payment-severe"}

          include_examples 'payments common'
          include_examples 'valid content'
        end

        describe  "Mortgage temp worried #{rgn}" do
          let(:region) { rgn }
          let(:content_prefix) {"holiday-mortgage-payment-temp-worried"}

          include_examples 'payments common'
          include_examples 'valid content'
        end

        describe  "Mortgage temp normal #{rgn}" do
          let(:region) { rgn }
          let(:content_prefix) {"holiday-mortgage-payment-temp-normal"}

          include_examples 'payments common'
          include_examples 'valid content'
        end

        describe  "Mortgage temp no change #{rgn}" do
          let(:region) { rgn }
          let(:content_prefix) {"holiday-mortgage-payment-no-change"}

          include_examples 'payments common'
          include_examples 'valid content'
        end
      end

    end

  end
end
