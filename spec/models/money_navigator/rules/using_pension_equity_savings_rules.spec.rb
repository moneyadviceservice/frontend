
RSpec.describe Questions, type: :model do
  #TODO: Using global smbols is bad.... do not use. fix this
  include ::Symbols

  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

  context 'Rule test: ' do
    context 'Using pensions, equity and savings ' do
      let(:section_code) { 'S9' }
      let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

      describe  "- pensions" do
        let(:heading_code) { 'H1' }
        let(:content_prefix) {'pensions-debt'}

        include_examples 'regionally valid content for regional rule'
      end

      describe  "- equity and mortgage" do
        let(:heading_code) { 'H2' }
        let(:content_prefix) {'equity-mortage-debt'}

        include_examples 'regionally valid content for regional rule'
      end

      describe  "- savings" do
        let(:heading_code) { 'H3' }
        let(:content_prefix) {'savings-debt'}

        include_examples 'regionally valid content for regional rule'
      end
    end

  end
end
