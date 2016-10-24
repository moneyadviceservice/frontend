module Core::Repository::CMS
  RSpec.describe PageFeedback do
    describe '#create' do
      subject { Core::Repository::CMS::PageFeedback.new.create(params) }

      context 'when valid' do
        let(:params) do

          {
            liked: true,
            article_id: 'example-article',
            session_id: 'ae2fcba004e16dffa54f91a46d274238',
            locale: 'en',
            slug: 'example-article'
          }
        end

        it 'returns ' do
          VCR.use_cassette('/en/articles/example-article/page_feedbacks') do
            expect(subject).to include(
              'id'         => 17,
              'liked'      => true,
              'session_id' => 'ae2fcba004e16dffa54f91a46d274238')
          end
        end
      end

      context 'when invalid' do
        let(:params) { {} }

        it 'returns false' do
          VCR.use_cassette('/en/articles/example/page_feedbacks-invalid') do
            expect(subject).to be(false)
          end
        end
      end
    end
  end
end
