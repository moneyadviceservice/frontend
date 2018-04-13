module Core::Repository::CMS
  RSpec.describe AttributeBuilder do
    let(:body) do
      File.read(
        'spec/fixtures/cms/beginners-guide-to-managing-your-money.json'
      )
    end
    let(:response) { OpenStruct.new(body: JSON.parse(body)) }
    let(:attribute_builder) { AttributeBuilder.new(:resource) }

    describe '.set_title_from_label' do
      let(:page_content) { { 'label' => :foo } }

      it 'copies label values to title' do
        attribute_builder.set_title_from_label(page_content)
        expect(page_content['title']).to eq page_content['label']
      end
    end

    describe '.set_body_from_content_block' do
      let(:page_content) do
        { 'blocks' => [{ 'identifier' => 'content', 'content' => :bar }] }
      end

      it 'uses block_composer to set body' do
        attribute_builder.set_body_from_content_block(page_content)
        expect(page_content['body']).to eq 'bar'
      end
    end

    describe '.translate_attributes_from_raw_blocks' do
      let(:page_content) do
        {
          'blocks' => [
            { 'identifier' => 'raw_tile_1_heading', 'content' => 'amazing!!!' }
          ]
        }
      end

      it 'adds a key without the `raw_` prefix' do
        attribute_builder.translate_attributes_from_raw_blocks(page_content)
        expect(page_content['tile_1_heading']).to eq(
          page_content['blocks'][0]['content']
        )
      end
    end

    describe '.group_nested_attributes' do
      let(:page_content) do
        {
          'tile_1_heading' => '1 header',
          'tile_1_image'   => '1 image',
          'tile_1_url'     => '1 url',
          'tile_1_srcset'  => '1 srcset',
          'tile_2_heading' => '2 header',
          'tile_2_image'   => '2 image',
          'tile_2_url'     => '2 url',
          'tile_2_srcset'  => '2 srcset',
          'tool_1_image'   => '1 image',
          'tool_1_url'     => '1 url',
          'tool_1_name'    => '1 name'
        }
      end

      let(:tile_1) do
        {
          'heading' => '1 header',
          'image'   => '1 image',
          'url'     => '1 url',
          'srcset'  => '1 srcset'
        }
      end

      before { attribute_builder.group_nested_attributes(page_content) }

      it 'modifies page_content and adds a new key per component detected' do
        expect(page_content.keys).to include 'tiles', 'tools'
      end

      it 'new components have a list for value' do
        expect(page_content['tiles']).to be_a(Array)
        expect(page_content['tiles'].size).to eq 2

        expect(page_content['tools']).to be_a(Array)
        expect(page_content['tools'].size).to eq 1
      end

      it 'builds a page_content with all the fields found for a component' do
        expect(page_content['tiles'][0]).to eq tile_1
      end
    end

    describe '.build' do
      subject { AttributeBuilder.build(response) }

      it 'returns title' do
        expect(subject['title']).to eq(
          'Beginner’s guide to managing your money'
        )
      end

      it 'returns description' do
        expect(subject['description']).to eq(
          'How to set up a budget, keep on top of your debts and start to save regularly'
        )
      end

      it 'returns categories' do
        expected = ['managing-money', 'taking-control-of-debt']
        expect(subject['categories']).to eq(expected)
      end

      it 'returns alternates' do
        expect(subject['alternates']).to eq(
          [
            {
              title: 'Canllaw syml i reoli eich arian',
              url: '/cy/articles/canllaw-syml-i-reoli-eich-arian',
              hreflang: 'cy'
            }
          ]
        )
      end

      it 'returns popular links' do
        expect(subject['related_content']['popular_links']).to be_present
      end

      it 'returns related links' do
        expect(subject['related_content']['related_links']).to be_present
      end

      it 'returns latest blog post links' do
        expect(subject['related_content']['latest_blog_post_links']).to be_present
      end

      it 'returns previous links' do
        expect(AttributeBuilder.build(response)['related_content']['previous_link']).to_not be_present
      end

      it 'returns next links' do
        expect(AttributeBuilder.build(response)['related_content']['next_link']).to be_present
      end

      it 'body is html' do
        # rubocop:disable Metrics/LineLength
        expect(AttributeBuilder.build(response)['body']).to include('<p><strong>Good money management can mean many things – from living within your means to saving for short and long-term goals, to having a realistic plan to pay off your debts. Read on if you want to learn how to set up a budget, make the most of your money, pay off debts or start saving.</strong></p>')
        # rubocop:enable Metrics/LineLength
      end

      context 'home page' do
        let(:body) { File.read('spec/fixtures/cms/modifiable-home-page.json') }

        it 'makes raw attributes acessible' do
          expect(AttributeBuilder.build(response)['heading']).to eql('head 1')
        end

        it 'groups numbered a attributes' do
          expect(AttributeBuilder.build(response)['tools'][0]['heading']).to eql('head 1')
          expect(AttributeBuilder.build(response)['tools'][0]['link']).to eql('https://example.com')
        end
      end
    end
  end
end
