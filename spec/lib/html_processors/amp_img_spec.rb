require 'html_processor'
require 'html_processor/amp_img'

RSpec.describe HTMLProcessor::AmpImg do
  let(:processor) { described_class.new(html) }

  describe '.process' do
    subject { Nokogiri::XML(processed_html.strip).children.first }
    let(:attributes) { subject.attributes.transform_values!(&:value) }
    let(:processed_html) { processor.process(HTMLProcessor::IMG) }

    let(:xpath) do
      '//img'
    end

    it 'creates an amp-img tag' do
      expect(subject.name).to eq('amp-img')
    end

    let(:html) do
      <<-EOHTML
          <img
              srcset="test_srcset"
              src="test_src"
              sizes="test_sizes"
              alt="test_alt"
              attribution="test_attribution"
              height="test_height"
              width="test_width" />
        EOHTML
    end

    it 'copies the attributes across correctly from the original iframe' do
      expect(attributes).to include(
        'srcset' => 'test_srcset',
        'src' => 'test_src',
        'sizes' => 'test_sizes',
        'alt' => 'test_alt',
        'attribution' => 'test_attribution',
        'height' => 'test_height',
        'width' => 'test_width',
        'layout' => 'responsive'
      )
    end

    describe 'supporting javascript disabled' do
      let(:amp_img_tag) { Nokogiri::XML(processed_html.strip).children.first }
      subject { amp_img_tag.children.first }
      let(:noscript_tag) { subject.children.first }
      let(:img_attributes) { noscript_tag.attributes.transform_values(&:value) }

      it 'creates a noscript tag containing the original img tag' do
        expect(subject.children.first.name).to eq('img')
      end

      it 'assigns the correct attributes to the inner img tag' do
        expect(img_attributes).to include(
          'srcset' => 'test_srcset',
          'src' => 'test_src',
          'sizes' => 'test_sizes',
          'alt' => 'test_alt',
          'attribution' => 'test_attribution',
          'height' => 'test_height',
          'width' => 'test_width'
        )
      end
    end

    context 'when attributes are missing' do
      let(:html) do
        <<-EOHTML
          <img src="test_src" />
        EOHTML
      end

      it 'does not create those attributes on the amp-iframe' do
        expect(attributes.keys).not_to include(
          %w[srcset sizes alt attribution height width]
        )
      end

      context 'when src attribute is missing' do
        let(:html) do
          <<-EOHTML
            <img />
          EOHTML
        end
        subject { processed_html.strip }

        it 'does not create the amp-img tag' do
          expect(subject).to eq('')
        end
      end
    end
  end
end
