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

    it 'strips the frame options header to allow all by default' do
      expect(subject.headers['X-Frame-Options']).to be_nil
    end
  end

  context 'when not a syndicated request' do
    controller do
      def syndicated_tool_request?
        false
      end

      def is_environment_on_uat?
        true
      end

      def index
        render inline: 'example', layout: nil
      end
    end

    subject { get :index }

    let(:digest) { '3094089b66468a09b6479fa0' }
    let(:data) { { digest: digest } }

    it 'does not render syndicated layout' do
      expect(subject).to_not render_template('layouts/syndicated')
    end

    it 'sets x frame options to SAMEORIGIN' do
      expect(subject.headers['X-Frame-Options']).to eql('SAMEORIGIN')
    end
  end

  describe '#show_floating_chat?' do
    it 'hides from all other pages' do
      expect(subject.show_floating_chat?).to be(false)
    end
  end

end
