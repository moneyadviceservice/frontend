require 'core/entities/article'

RSpec.describe ContentItemDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(content_item) }

  let(:content_item) { instance_double(Core::Article, id: 'bob') }

  it { is_expected.to respond_to(:alternate_options) }
  it { is_expected.to respond_to(:canonical_url) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:title) }

  describe '#alternate_options' do
    context 'when there are no alternates' do
      before { allow(content_item).to receive(:alternates) { [] } }

      it 'returns an empty hash' do
        expect(decorator.alternate_options).to be_a(Hash)
        expect(subject.alternate_options).to be_empty
      end
    end

    context 'when there are alternates' do
      before { allow(content_item).to receive(:alternates) { [alternate] } }

      let(:alternate) { double(hreflang: locale, url: url) }
      let(:locale) { double }
      let(:url) { double }

      it 'returns a hash of locale => url pairs' do
        expect(subject.alternate_options).to include(locale => url)
      end
    end
  end

  describe '#canonical_url' do
    before do
      allow(content_item.class).to receive_messages(to_s: 'core/content_item')
      allow(helpers).to receive_messages(content_item_url: '/content_items/bob')
    end

    it 'requests the path from the object with the name derived from the object class' do
      expect(helpers).to receive(:content_item_url)
      subject.canonical_url
    end

    it 'returns the path to the content_item' do
      expect(subject.canonical_url).to eq('/content_items/bob')
    end
  end

  describe '#intro' do
    let(:fixture) { 'spec/fixtures/pawnbrokers-how-they-work.json' }
    let(:content_item) do
      instance_double(Core::Article,
                      id:          'bob',
                      title:       'uncle-bob-is-richer-than-you',
                      description: 'uncle is rich',
                      body:        MultiJson.load(File.read(fixture))['body'])
    end

    let(:processed_body) { Nokogiri::HTML(decorator.send(:processed_body)) }
    let(:html) { decorator.intro }

    it 'returns just the intro' do
      expect(html).to eql processed_body.search(HTMLProcessor::INTRO_PARAGRAPH).inner_html
    end
  end

  describe '#content' do
    let(:content_item) do
      instance_double(Core::Article,
                      id:          'bob',
                      title:       'uncle-bob-is-richer-than-you',
                      description: 'uncle is rich',
                      body:        MultiJson.load(File.read(fixture))['body'])
    end

    let(:html) { Nokogiri::HTML(decorator.content) }

    context 'when the object body needs processing' do
      let(:fixture) { 'spec/fixtures/pawnbrokers-how-they-work.json' }

      it 'strips images from intro paragraphs' do
        expect(html.search(HTMLProcessor::INTRO_IMG)).to be_empty
      end

      it 'strips action email links' do
        expect(html.search(HTMLProcessor::ACTION_EMAIL)).to be_empty
      end

      it 'strips action forms' do
        expect(html.search(HTMLProcessor::ACTION_FORM)).to be_empty
      end

      it 'strips out the intro' do
        expect(html.search(HTMLProcessor::INTRO_PARAGRAPH)).to be_empty
      end
    end

    context 'when the object body contains a video embeded in an iframe' do
      let(:fixture) { 'spec/fixtures/responsive-video.json' }

      it 'wraps the content in a div[@class="video-wrapper"]' do
        nodes = html.search('//div[@class="video-wrapper"]/p/iframe' +
                              '[starts-with(@src, "https://www.youtube.com/embed")]')

        expect(nodes).to_not be_empty
      end
    end

    context 'when the object contains a table' do
      let(:fixture) { 'spec/fixtures/responsive-table.json' }

      it 'wraps the content in a div[@class="table-wrapper"]' do
        nodes = html.search('//div[@class="table-wrapper"]/table[@class="datatable-default"]')

        expect(nodes).to_not be_empty
      end
    end

    context 'when the object contains collapsible content' do
      let(:fixture) { 'spec/fixtures/collapsibe.json' }

      it 'strips collapse span' do
        expect(html.search(HTMLProcessor::COLLAPSIBLE_SPAN)).to be_empty
      end
    end
  end

  describe '#parent_categories_with_contents' do
    let(:category_another_content_item) { double }
    let(:another_category_content_item) { double }
    let(:category_contents) { [category_another_content_item, another_category_content_item] }
    let(:category) { instance_double(Core::Category, contents: category_contents) }
    let(:categories) { [category] }
    let(:content_item) { instance_double(Core::Article, id: 'base content_item', categories: categories) }

    subject { decorator.send(:parent_categories_with_contents) }

    it 'returns a hash with the category in the keys' do
      expect(subject.keys).to eq categories
    end

    it 'returns a hash with the contents in the values' do
      expect(subject.values).to eq [category_contents]
    end
  end

  describe '#limited_parent_categories_with_contents' do
    before do
      allow(decorator).to receive(:parent_categories_with_contents) { contents_hash }
    end

    let(:limit) { 4 }
    subject { decorator.send(:limited_parent_categories_with_contents, limit) }

    context 'when we only have one category' do
      let(:category) { double }
      let(:category_items) { [double] }

      # We dup this hash otherwise it will remain referenced and
      # have it's contents removed within the method we're testing.
      let(:contents_hash) { { category => category_items.dup } }

      it 'returns a single item hash with the category as the key' do
        expect(subject.keys.first).to eq category
      end

      context 'when we have fewer items than the limit' do
        it 'returns a single item hash with all items in the value' do
          expect(subject.values.first).to eq category_items
        end
      end

      context 'when we have more items than the limit' do
        let(:first_four_items) { [double, double, double, double] }
        let(:superfluous_items) { [double] }
        let(:category_items) { first_four_items + superfluous_items }

        it 'returns a single item hash with the items in the value truncated by limit' do
          expect(subject.values.first).to eq first_four_items
        end
      end
    end

    context 'when we have two categories' do
      let(:first_category) { double }
      let(:first_category_items) { [double] }

      let(:second_category) { double }
      let(:second_category_items) { [double] }

      # Again, we dup the items hash otherwise it they remain referenced and
      # have their's contents removed within the method we're testing.
      let(:contents_hash) do
        {
          first_category => first_category_items.dup,
          second_category => second_category_items.dup
        }
      end

      it 'returns a hash with the categories as keys' do
        expect(subject.keys).to eq [first_category, second_category]
      end

      context 'when we have more than enough items in both hashes' do
        let(:first_category_first_two_items) { [double, double] }
        let(:first_category_superfluous_items) { [double] }
        let(:first_category_items) { first_category_first_two_items + first_category_superfluous_items }

        let(:second_category_first_two_items) { [double, double] }
        let(:second_category_superfluous_items) { [double] }
        let(:second_category_items) { second_category_first_two_items + second_category_superfluous_items }

        it "returns a hash with the first category's values truncated" do
          expect(subject.values.first).to eq first_category_first_two_items
        end

        it "returns a hash with the second category's values truncated" do
          expect(subject.values[1]).to eq second_category_first_two_items
        end
      end

      context 'when the first category has too few items' do
        let(:first_category_items) { [double] }

        it "returns a hash with all the first category's values present" do
          expect(subject.values.first).to eq first_category_items
        end

        context 'and the second category also has too few items' do
          let(:second_category_items) { [double, double] }

          it "returns a hash with all the second category's values present" do
            expect(subject.values[1]).to eq second_category_items
          end
        end

        context 'and the second category has more than enough items' do
          let(:second_category_first_three_items) { [double, double, double] }
          let(:second_category_superfluous_items) { [double] }
          let(:second_category_items) { second_category_first_three_items + second_category_superfluous_items }

          it "returns a hash with the second category's values truncated" do
            expect(subject.values[1]).to eq second_category_first_three_items
          end
        end
      end

      context 'when the second category has too few items' do
        let(:second_category_items) { [double] }

        it "returns a hash with all the second category's values present" do
          expect(subject.values[1]).to eq second_category_items
        end

        context 'and the first category also has too few items' do
          let(:first_category_items) { [double, double] }

          it "returns a hash with all the first category's values present" do
            expect(subject.values.first).to eq first_category_items
          end
        end

        context 'and the first category has more than enough items' do
          let(:first_category_first_three_items) { [double, double, double] }
          let(:first_category_superfluous_items) { [double] }
          let(:first_category_items) { first_category_first_three_items + first_category_superfluous_items }

          it "returns a hash with the first category's values truncated" do
            expect(subject.values.first).to eq first_category_first_three_items
          end
        end
      end
    end

  end
end
