require 'html_processor'
require 'html_processor/amp_iframe'

RSpec.describe HTMLProcessor::AmpIframe do
  let(:processor) { described_class.new(html) }

  describe '.process' do
    subject { Nokogiri::XML(processed_html.strip).children.first }
    let(:attributes) { subject.attributes.transform_values!(&:value) }

    let(:processed_html) { processor.process(HTMLProcessor::NON_VIDEO_IFRAME) }

    let(:xpath) do
      '//iframe[not(starts-with(@src, "https://www.youtube.com/embed"))]'
    end

    context 'when attributes are present' do
      let(:html) do
        <<-EOHTML
          <iframe
            src="https://google.com"
            alt="test_alt"
            height="test_height"
            width="test_width"
            srcdoc="test_srcdoc"
            frameborder="test_frameborder"
            allowfullscreen="test_allowfullscreen"
            allowpaymentrequest="test_allowpaymentrequest"
            allowtransparency="test_allowtransparency"
            referrerpolicy="test_referrerpolicy"
            sandbox="test_sandbox" />
        EOHTML
      end

      it 'copies the attributes across correctly from the original iframe' do
        expect(attributes).to include(
          'src' => 'https://google.com',
          'alt' => 'test_alt',
          'height' => 'test_height',
          'width' => 'test_width',
          'srcdoc' => 'test_srcdoc',
          'frameborder' => 'test_frameborder',
          'allowfullscreen' => 'test_allowfullscreen',
          'allowpaymentrequest' => 'test_allowpaymentrequest',
          'allowtransparency' => 'test_allowtransparency',
          'referrerpolicy' => 'test_referrerpolicy',
          'sandbox' => 'test_sandbox'
        )
      end
    end

    context 'when attributes are missing' do
      let(:html) do
        <<-EOHTML
          <iframe src="https://google.com" />
        EOHTML
      end

      it 'does not create those attributes on the amp-iframe' do
        expect(attributes.keys).not_to include(
          %w[alt
             height
             width
             srcdoc
             frameborder
             allowfullscreen
             allowpaymentrequest
             allowtransparency
             referrerpolicy
             sandbox]
        )
      end
    end

    context 'when the iframe src is not https' do
      let(:html) do
        <<-EOHTML
          <iframe src="http://google.com"></iframe>
        EOHTML
      end
      subject { processed_html.strip }

      it 'does not create the amp-iframe tag' do
        expect(subject).to eq('')
      end
    end
  end
end
