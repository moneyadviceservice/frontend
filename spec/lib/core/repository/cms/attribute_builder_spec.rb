module Core::Repository::CMS
  RSpec.describe AttributeBuilder do
    let(:body) { File.read('spec/fixtures/cms/beginners-guide-to-managing-your-money.json') }
    let(:response) { OpenStruct.new(body: JSON.parse(body)) }

    describe '.build' do
      subject { AttributeBuilder.build(response) }

      it 'returns title' do
        expect(subject['title']).to eq('beginners-guide-to-managing-your-money')
      end

      it 'returns alternates' do
        expect(subject['alternates']).to eq([
          {
            title: 'Canllaw syml i reoli eich arian',
            url: '/cy/articles/canllaw-syml-i-reoli-eich-arian',
            hreflang: 'cy'
          }
        ])
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
        expect(AttributeBuilder.build(response)['related_content']['previous_link']).to be_present
      end

      it 'returns next links' do
        expect(AttributeBuilder.build(response)['related_content']['next_link']).to be_present
      end
    end
  end
end
