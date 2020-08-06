

RSpec.describe Questions, type: :model do
  include ::Symbols

  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

  context 'Rule test: ' do
    context 'Your money moving forward ' do
      let(:section_code) { 'S3' }

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        let(:region) { rgn }

        describe  "severe income drop" do
          let(:heading_code) { 'H1' }
          let(:content_prefix) {"back-on-track-severe"}

          include_examples 'regionally valid content'
        end

        describe  "income drop" do
          let(:heading_code) { 'H2' }
          let(:content_prefix) {"back-on-track"}

          include_examples 'regionally valid content'
        end

        describe  "looking forward" do
          let(:heading_code) { 'H3' }
          let(:content_prefix) {"looking-forward"}

          include_examples 'regionally valid content'
        end

      end

    end
  end
end
