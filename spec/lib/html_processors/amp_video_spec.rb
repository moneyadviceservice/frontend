require 'html_processor'
require 'html_processor/amp_video'

RSpec.describe HTMLProcessor::AmpVideo do
  subject(:processor) { described_class.new(html) }

  let(:html) do
    <<-EOHTML
      <iframe frameborder="0" height="413" width="680" src="https://www.youtube.com/embed/3ciEDiokPkw?rel=0">
      </iframe>
    EOHTML
  end

  describe '.process' do
    subject(:processed_html) { processor.process(HTMLProcessor::VIDEO_IFRAME) }

    let(:xpath) do
      '//div[@class="video-wrapper"]/*/iframe[starts-with(@src, "https://www.youtube.com/embed")]'
    end

    it 'does not modify title attribute', focus: true do
      expect(processed_html.strip).to eq('<amp-youtube data-videoid="3ciEDiokPkw" layout="responsive" width="480" height="270"></amp-youtube>')
    end
  end
end
