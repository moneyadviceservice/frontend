module Core::Repository::CMS
  RSpec.describe AttributeBuilder do
    let(:body) { File.read('spec/fixtures/cms/beginners-guide-to-managing-your-money.json') }
    let(:response) { OpenStruct.new(body: JSON.parse(body)) }
    subject { AttributeBuilder.build(response) }

    describe 'related_content' do

      it 'has title' do
        expect(subject['title']).to eq('beginners-guide-to-managing-your-money')
      end

      it 'has popular links' do
        expect(subject['related_content']['popular_links']).to be_present
      end

      it 'has related links' do
        expect(subject['related_content']['related_links']).to be_present
      end

      it 'has latest blog post links' do
        expect(subject['related_content']['latest_blog_post_links']).to be_present
      end

      it 'has previous links' do
        expect(AttributeBuilder.build(response)['related_content']['previous_link']).to be_present
      end

      it 'has next links' do
        expect(AttributeBuilder.build(response)['related_content']['next_link']).to be_present
      end
    end
  end
end
