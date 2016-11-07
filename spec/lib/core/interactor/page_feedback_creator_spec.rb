RSpec.describe Core::PageFeedbackCreator do
  let(:params) { {} }

  describe '#call' do
    context 'when feedback is created' do
      let(:page_feedback) { Core::PageFeedback.new(data['id'], data) }
      let(:data) do
        { 'id' => 2, 'liked' => true }
      end

      before do
        expect(subject.repository).to receive(:create).and_return(data)
      end

      it 'returns entity' do
        expect(subject.call(params)).to eq(page_feedback)
      end
    end

    context 'when feedback is not created' do
      before do
        expect(subject.repository).to receive(:create).and_return(false)
      end

      it 'returns false' do
        expect(subject.call(params)).to be(false)
      end
    end
  end
end
