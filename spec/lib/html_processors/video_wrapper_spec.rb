require 'html_processor'
require 'html_processor/video_wrapper'

describe HTMLProcessor::VideoWrapper do
  subject(:processor) { HTMLProcessor::VideoWrapper.new(html) }

  let(:html) {
    <<-EOHTML
<p>
  <iframe frameborder="0" height="413" width="680" src="https://www.youtube.com/embed/3ciEDiokPkw">
  </iframe>
</p>
    EOHTML
  }

  describe '.process' do
    subject(:processed_html) { processor.process(HTMLProcessor::VIDEO_IFRAME) }

    let(:xpath) do
      '//div[@class="video-wrapper"]/*/iframe[starts-with(@src, "https://www.youtube.com/embed")]'
    end

    it 'wraps the given elements' do
      expect(Nokogiri::HTML(processed_html).xpath(xpath).size).to eq(1)
    end
  end
end
