require 'nokogiri/html'

RSpec.describe HeadingTagHelper, '#heading_tag', type: :helper do
  subject(:tag) { Nokogiri::HTML.fragment(html).children.first }

  let(:text) { 'My heading' }

  context 'when no level is defined' do
    let(:html) { helper.heading_tag(text) }

    it 'is a h1 tag' do
      expect(tag.name).to eq('h1')
    end

    it 'has the text' do
      expect(tag.text).to eq(text)
    end

    it "has an 'aria-level' of '1'" do
      expect(tag.attributes['aria-level'].name).to eq('aria-level')
      expect(tag.attributes['aria-level'].value).to eq('1')
    end

    it "has an 'role' of 'heading'" do
      expect(tag.attributes['role'].name).to eq('role')
      expect(tag.attributes['role'].value).to eq('heading')
    end
  end

  context 'when a level is defined' do
    let(:html) { helper.heading_tag(text, level: 4) }

    it 'is a heading tag for that level' do
      expect(tag.name).to eq('h4')
    end

    it 'has the text' do
      expect(tag.text).to eq(text)
    end

    it "has an 'aria-level' for that level" do
      expect(tag.attributes['aria-level'].name).to eq('aria-level')
      expect(tag.attributes['aria-level'].value).to eq('4')
    end

    it "has an 'role' of 'heading'" do
      expect(tag.attributes['role'].name).to eq('role')
      expect(tag.attributes['role'].value).to eq('heading')
    end
  end

  context 'when optional attributes are specified' do
    let(:html) { helper.heading_tag(text, class: 'foo') }

    it 'is a h1 tag' do
      expect(tag.name).to eq('h1')
    end

    it 'includes the specified attributes' do
      expect(tag.attributes).to include('aria-level', 'role', 'class')
    end
  end

  context 'when a block is given' do
    let(:html) do
      helper.heading_tag(class: 'foo') do
        'My text'
      end
    end

    it 'has the text' do
      expect(tag.text).to eq('My text')
    end
  end
end
