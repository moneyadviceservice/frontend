require 'html_processor'
require 'html_processor/amp_video'

RSpec.describe HTMLProcessor::AmpVideo do
  subject(:processor) { described_class.new(html) }

  let(:html) do
    <<-HTML
      <iframe
        src="https://www.youtube.com/embed/3ciEDiokPkw?rel=0"
        frameborder="0"
        height="413"
        width="680">
      </iframe>
    HTML
  end

  describe '.process' do
    subject { Nokogiri::XML(processed_html.strip).children.first }
    let(:processed_html) { processor.process(HTMLProcessor::VIDEO_IFRAME) }
    let(:attributes) { subject.attributes.transform_values!(&:value) }

    let(:xpath) do
      '//div[@class="video-wrapper"]/*/iframe[starts-with(@src, "https://www.youtube.com/embed")]' # rubocop:disable Metrics/LineLength
    end

    it 'creates an amp-youtube tag' do
      expect(subject.name).to eq('amp-youtube')
    end

    it 'assigns a height, width, video id and layout to the amp-youtube tag' do
      expect(attributes).to include(
        'height' => '270',
        'width' => '480',
        'data-videoid' => '3ciEDiokPkw',
        'layout' => 'responsive'
      )
    end
  end
end
