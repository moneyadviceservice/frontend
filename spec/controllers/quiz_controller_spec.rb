RSpec.describe QuizController, type: :controller do
  describe '#syndicated_tool_request?' do
    it 'retuns true' do
      expect(controller).to be_syndicated_tool_request
    end
  end
end
