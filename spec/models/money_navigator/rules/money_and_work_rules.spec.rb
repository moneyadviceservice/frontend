

RSpec.describe Questions, type: :model do
  #TODO: Using global smbols is bad.... do not use. fix this
  include ::Symbols

  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

  context 'Rule test: ' do
    context 'Money and work ' do
      let(:section_code) { 'S4' }

      describe  "Managing " do
        let(:region) { [ 'england', 'wales', 'scotland', 'ni'] }
        let(:heading_code) { 'H1' }
        let(:content_prefix) {'managing-self-employed'}

        include_examples 'regionally valid content for regional rule'
      end


      describe  "Urgent help " do
        let(:region) { [ 'england', 'wales', 'scotland'] }
        let(:heading_code) { 'H2' }
        let(:content_prefix) {'urgent-help-self-employed'}

        include_examples 'regionally valid content for regional rule'
      end

      describe  "Urgent help ni" do
        let(:region) { 'ni' }
        let(:heading_code) { 'H2' }
        let(:content_prefix) {"urgent-help-self-employed"}

        include_examples 'nationally valid content for national rule'
      end

      describe  "Preparing for redundancy " do
        let(:region) { [ 'england', 'wales', 'scotland', 'ni'] }
        let(:heading_code) { 'H3' }
        let(:content_prefix) {'preparing-redundancy'}

        include_examples 'regionally valid content for regional rule'
      end

      describe  "Unemployed " do
        let(:region) { [ 'england', 'wales', 'scotland', 'ni'] }
        let(:heading_code) { 'H4' }
        let(:content_prefix) {'unemployed'}

        include_examples 'regionally valid content for regional rule'
      end

    end
  end
end
