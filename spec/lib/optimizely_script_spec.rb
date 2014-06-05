require 'spec_helper'
require 'optimizely_script'

RSpec.describe OptimizelyScript do
  describe '#to_s' do
    let(:data) { { digest: digest } }
    let(:digest) { '3094089b66468a09b6479fa0' }
    subject { described_class.new.to_s }

    context 'no version file' do
      before do
        expect(File).to receive(:exist?).and_return(false)
      end

      it { is_expected.to eq('') }
    end

    context 'with broken version file' do
      before do
        expect(File).to receive(:exist?).and_return(true)
        expect(File).to receive(:open).and_return(double(read: '{broken json}'))
      end

      it { is_expected.to eq(%{<script src="/a/optimizely/.js"></script>}) }
    end

    context 'with version file' do
      before do
        expect(File).to receive(:exist?).and_return(true)
        expect(File).to receive(:open).and_return(double(read: JSON[data]))
      end

      it { is_expected.to eq(%{<script src="/a/optimizely/#{digest}.js"></script>}) }
    end
  end
end
