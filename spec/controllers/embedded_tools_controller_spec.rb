RSpec.describe EmbeddedToolsController, type: :controller do

  describe '#alternate_url' do
    before do
      allow(subject).to receive(:url_for).and_return('http://some.url')
    end

    context 'no alternate_url on the mount_point' do
      let(:mount_point) do
        double(alternate_locale: 'en', alternate_tool_id: 'tool_name')
      end

      it 'ignores the mount point' do
        allow(ToolMountPoint).to receive(:for).and_return(mount_point)
        expect(subject.send(:alternate_url)).to eq('http://some.url')
      end
    end

    context 'mount_point has alternate_url' do
      let(:mount_point) do
        double(alternate_url: 'http://alternate.url',
               alternate_locale: 'en', alternate_tool_id: 'tool_name')
      end

      it 'returns an alternate_url if one is available' do
        allow(ToolMountPoint).to receive(:for).and_return(mount_point)
        expect(subject.send(:alternate_url)).to eq('http://alternate.url')
      end

      it 'passes the url and locale to the mount_point' do
        allow(ToolMountPoint).to receive(:for).and_return(mount_point)
        expect(mount_point).to receive(:alternate_url).with('http://some.url', 'en')
        subject.send(:alternate_url)
      end
    end
  end

end
