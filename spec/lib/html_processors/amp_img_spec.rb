require 'html_processor'
require 'html_processor/amp_img'

RSpec.describe HTMLProcessor::AmpImg do
  let(:processor) { described_class.new(html) }

  describe '.process' do
    let(:parent_container) { Nokogiri::XML(processed_html.strip).children.first }
    let(:amp_img_tag) { parent_container.children.first }
    let(:noscript_tag) { amp_img_tag.children.first }
    let(:attributes) { subject.attributes.transform_values!(&:value) }
    let(:processed_html) { processor.process(HTMLProcessor::IMG) }

    let(:xpath) do
      '//img'
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

    describe 'generated parent container' do
      subject { parent_container }

      it 'is a div' do
        expect(subject.name).to eq('div')
      end

      it 'it has the correct styles for a dynamic width amp-img' do
        expect(subject.attribute('class').value).to include('amp-img-container')
      end
    end

    describe 'generated amp-img tag' do
      subject { amp_img_tag }

      it 'is an amp-img' do
        expect(subject.name).to eq('amp-img')
      end

      it 'copies the attributes across correctly from the original img' do
        expect(attributes).to include(
          'srcset' => 'test_srcset',
          'src' => 'test_src',
          'sizes' => 'test_sizes',
          'alt' => 'test_alt',
          'attribution' => 'test_attribution',
          'height' => 'test_height',
          'width' => 'test_width',
          'layout' => 'fill',
          'class' => 'contain'
        )
      end
    end

    describe 'supporting javascript disabled' do
      subject { noscript_tag }
      let(:inner_img_tag) { noscript_tag.children.first }
      let(:img_attributes) { inner_img_tag.attributes.transform_values(&:value) }

      it 'creates a noscript tag containing the original img tag' do
        expect(subject.name).to eq('noscript')
        expect(inner_img_tag.name).to eq('img')
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
      subject { amp_img_tag }

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
