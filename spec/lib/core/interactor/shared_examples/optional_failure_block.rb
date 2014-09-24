RSpec.shared_examples_for 'optional failure block' do
  context 'when a block is given' do
    it 'calls the block' do
      expect { |probe| subject.call(&probe) }.to yield_control
    end
  end

  context 'when no block is given' do
    it 'returns nil' do
      expect(subject.call).to be_nil
    end
  end
end
