RSpec.describe Core::PageFeedbackUpdator do
  let(:params) { {} }

  describe '#call' do
    context 'when feedback is updated' do
      let(:page_feedback) { Core::PageFeedback.new(data['id'], data) }
      let(:data) do
        { 'id' => 2, 'liked' => true }
      end

      before do
        expect(subject.repository).to receive(:update).and_return(data)
      end

      it 'returns entity' do
        expect(subject.call(params)).to eq(page_feedback)
      end
    end

    context 'when feedback is not updated' do
      before do
        expect(subject.repository).to receive(:update).and_return(false)
      end

      it 'returns false' do
        expect(subject.call(params)).to be(false)
      end
    end
  end
end
