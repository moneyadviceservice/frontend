require 'spec_helper'
require 'html_processor'

describe HTMLProcessor::VideoWrapper do

  let(:html) {
    <<-EOHTML
<p>
  <iframe frameborder="0" height="413" width="680" src="https://www.youtube.com/embed/3ciEDiokPkw">
  </iframe>
</p>
    EOHTML
  }

  let(:processor) { HTMLProcessor::VideoWrapper.new(html) }
  let(:xpath) do
    '//div[@class="video-wrapper"]/*/iframe[starts-with(@src, "https://www.youtube.com/embed")]'
  end

  it 'wraps the given xpaths' do
    processed_html = processor.process(HTMLProcessor::VIDEO_IFRAME)
    expect(Nokogiri::HTML(processed_html).xpath(xpath).size).to eq(1)
  end
end
