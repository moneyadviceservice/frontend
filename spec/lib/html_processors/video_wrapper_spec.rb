require 'html_processor'
require 'html_processor/video_wrapper'

RSpec.describe HTMLProcessor::VideoWrapper do
  subject(:processor) { described_class.new(html) }

  let(:html) do
    <<-EOHTML
      <p>
        <iframe frameborder="0" height="413" width="680" src="https://www.youtube.com/embed/3ciEDiokPkw">
        </iframe>
      </p>
    EOHTML
  end

  describe '.process' do
    subject(:processed_html) { processor.process(HTMLProcessor::VIDEO_IFRAME) }

    let(:xpath) do
      '//div[@class="video-wrapper"]/*/iframe[starts-with(@src, "https://www.youtube.com/embed")]'
    end
    let(:node) { Nokogiri::HTML(processed_html).xpath(xpath) }

    it 'wraps the given elements' do
      expect(node.size).to eq(1)
    end

    context 'when title is not include' do
      it 'adds the attribute title' do
        expect(node).to_not be_nil
      end
    end

    context 'when title is already included' do
      let(:html) do
        <<-EOHTML
         <p>
          <iframe title="Video: test video" frameborder="0" height="413" width="680" src="https://www.youtube.com/embed/3ciEDiokPkw">
          </iframe>
        </p>
        EOHTML
      end

      it 'does not modify title attribute' do
        expect(node.attribute('title').value).to eq('Video: test video')
      end
    end
  end
end
