module Core::Repository::CMS
  RSpec.describe PageFeedback do
    describe '#create' do
      subject { Core::Repository::CMS::PageFeedback.new.create(params) }

      context 'when valid' do
        let(:params) do

          {
            liked: true,
            article_id: 'press-release-money-advice-service-appoints-new-debt-director',
            session_id: 'ae2fcba004e16dffa54f91a46d274238',
            locale: 'en',
            slug: 'press-release-money-advice-service-appoints-new-debt-director'
          }
        end

        it 'returns page feedback' do
          expect(subject).to include(
            'id'             => 1,
            'likes_count'    => 1,
            'dislikes_count' => 0,
            'session_id'     => 'ae2fcba004e16dffa54f91a46d274238')
        end
      end

      context 'when invalid' do
        let(:params) do
          {
            locale: 'en',
            article_id: 'a-guide-to-lifetime-isas'
          }
        end

        it 'returns false' do
          expect(subject).to be(false)
        end
      end
    end
  end
end
