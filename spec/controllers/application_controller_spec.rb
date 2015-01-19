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
  end

  context 'when not a syndicated request' do
    controller do
      def syndicated_tool_request?
        false
      end

      def index
        render inline: 'example', layout: true
      end
    end

    subject { get :index }

    it 'renders application layout' do
      expect(subject).to render_template('layouts/application')
    end
  end
end
