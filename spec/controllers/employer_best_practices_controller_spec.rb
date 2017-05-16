RSpec.describe EmployerBestPracticesController, type: :controller do
  context 'when syndication requests' do
    before do
      allow(controller).to receive(:syndicated_tool_request?).and_return(true)
    end

    describe '#engine_content?' do
      it 'returns false' do
        expect(controller).to_not be_engine_content
      end
    end

    describe '#engine_name' do
      it 'returns "employer_best_practices"' do
        expect(controller.engine_name).to eq('employer_best_practices')
      end
    end

    describe '#alternate_tool_id' do
      it 'returns "employer-best-practices"' do
        expect(controller.alternate_tool_id).to eq('employer-best-practices')
      end
    end

    describe '#check_syndicated_layout' do
      it 'returns "engine_syndicated"' do
        expect(controller.check_syndicated_layout).to eq('engine_syndicated')
      end
    end
  end

  context 'when not syndicated requests' do
    before do
      allow(controller).to receive(:syndicated_tool_request?).and_return(false)
    end

    describe '#check_syndicated_layout' do
      it 'returns nil' do
        expect(controller.check_syndicated_layout).to be(nil)
      end
    end
  end
end
