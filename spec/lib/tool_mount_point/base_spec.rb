require 'tool_mount_point/base'

RSpec.describe ToolMountPoint::Base do
  subject(:mount_point) { described_class.new }

  describe '#matches?' do
    let(:params) do
      {
        locale: request_locale,
        tool_id: request_tool_id,
      }
    end
    let(:request) { double('request', params: params) }
    let(:mount_point_en_tool_id) { double }
    let(:mount_point_cy_tool_id) { double }

    subject { mount_point.matches?(request) }

    before do
      allow(mount_point).to receive(:en_id) { mount_point_en_tool_id }
      allow(mount_point).to receive(:cy_id) { mount_point_cy_tool_id }
    end

    context 'when the requested locale is "en"' do
      let(:request_locale) { 'en' }

      context 'and the tool id is the the tool\'s English id' do
        let(:request_tool_id) { mount_point_en_tool_id }

        it 'returns true' do
          expect(subject).to be_truthy
        end
      end

      context 'and the tool id is not the the tool\'s English id' do
        let(:request_tool_id) { double }

        it 'returns false' do
          expect(subject).to be_falsey
        end
      end
    end

    context 'when the requested locale is "cy"' do
      let(:request_locale) { 'cy' }

      context 'and the tool id is the the tool\'s Welsh id' do
        let(:request_tool_id) { mount_point_cy_tool_id }

        it 'returns true' do
          expect(subject).to be_truthy
        end
      end

      context 'and the tool id is not the the tool\'s Welsh id' do
        let(:request_tool_id) { double }

        it 'returns false' do
          expect(subject).to be_falsey
        end
      end
    end
  end

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
