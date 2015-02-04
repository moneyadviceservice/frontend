RSpec.describe ApplicationController, type: :controller do
  context 'when syndicated request' do
    controller do
      def syndicated_tool_request?
        true
      end

      def index
        render inline: 'example', layout: true
      end
    end

    subject { get :index }

    it 'renders syndicated layout' do
      expect(subject).to render_template('layouts/syndicated')
    end

    it 'sets x frame options to ALLOWALL' do
      expect(subject.headers['X-Frame-Options']).to eql('ALLOWALL')
    end
  end

  context 'when not a syndicated request' do
    controller do
      def syndicated_tool_request?
        false
      end

      def index
        render inline: 'example', layout: nil
      end
    end

    subject { get :index }

    it 'does not render syndicated layout' do
      expect(subject).to_not render_template('layouts/syndicated')
    end

    it 'sets x frame options to SAMEORIGIN' do
      expect(subject.headers['X-Frame-Options']).to eql('SAMEORIGIN')
    end
  end
end
