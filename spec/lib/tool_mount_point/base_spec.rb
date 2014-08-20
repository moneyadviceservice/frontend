require 'tool_mount_point/base'

RSpec.describe ToolMountPoint::Base do
  subject(:mount_point) { described_class.new }

  describe '#alternate_locale' do
    subject { mount_point.alternate_locale(current_locale) }

    context 'when the provided locale is "en"' do
      let(:current_locale) { 'en' }

      it 'returns "cy"' do
        expect(subject).to eql('cy')
      end
    end

    context 'when the provided locale is "cy"' do
      let(:current_locale) { 'cy' }

      it 'returns "en"' do
        expect(subject).to eql('en')
      end
    end
  end

  describe '#alternate_tool_id' do
    let(:en_tool_id) { double }
    let(:cy_tool_id) { double }

    before do
      allow(mount_point).to receive(:en_id) { en_tool_id }
      allow(mount_point).to receive(:cy_id) { cy_tool_id }
    end

    subject { mount_point.alternate_tool_id(current_tool_id) }

    context 'when the provided tool_id is the English id' do
      let(:current_tool_id) { en_tool_id }

      it 'returns the Welsh id' do
        expect(subject).to eql(cy_tool_id)
      end
    end

    context 'when the provided tool_id is the Welsh id' do
      let(:current_tool_id) { cy_tool_id }

      it 'returns the English id' do
        expect(subject).to eql(en_tool_id)
      end
    end
  end
end
