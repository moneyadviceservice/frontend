require 'html_processor'
require 'html_processor/amp_img'

RSpec.describe HTMLProcessor::AmpImg do
  let(:processor) { described_class.new(html) }

  describe '.process' do
    let(:parent_container) do
      Nokogiri::XML(processed_html.strip).children.first
    end
    let(:amp_img_tag) { parent_container.children.first }
    let(:amp_img_attrs) { amp_img_tag.attributes.transform_values(&:value) }
    let(:noscript_tag) { amp_img_tag.children.first }
    let(:inner_img_tag) { noscript_tag.children.first }
    let(:img_attributes) { inner_img_tag.attributes.transform_values(&:value) }
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

    it 'the parent container is a div' do
      expect(parent_container.name).to eq('div')
    end

    it 'the parent container has the class amp-img-container' do
      expect(parent_container.attribute('class').value)
        .to include('amp-img-container')
    end

    it 'the generated amp-img tag is an amp-img' do
      expect(amp_img_tag.name).to eq('amp-img')
    end

    it 'copies the attributes across correctly from the original img' do
      expect(amp_img_attrs).to include(
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


    it 'creates a noscript tag containing the original img tag' do
      expect(noscript_tag.name).to eq('noscript')
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

    context 'when attributes are missing' do
      let(:html) do
        <<-EOHTML
          <img src="test_src" />
        EOHTML
      end

      it 'does not create those attributes on the amp-iframe' do
        expect(amp_img_attrs.keys).not_to include(
          %w[srcset sizes alt attribution height width]
        )
      end
    end

    context 'when src attribute is missing' do
      let(:html) do
        <<-EOHTML
          <img />
        EOHTML
      end

      it 'does not create the amp-img tag' do
        expect(processed_html.strip).to eq('')
      end
    end
  end
end
