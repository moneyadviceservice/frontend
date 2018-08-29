RSpec.describe 'PACS', type: :request do
  ["/en/tools/#{ToolMountPoint::Pacs::EN_ID}",
   "/cy/tools/#{ToolMountPoint::Pacs::CY_ID}"].each do |path|
    describe path do
      before do
        allow(Pacs::PaymentAccountCollection)
          .to receive(:latest).and_return(
            instance_double(
              Pacs::PaymentAccountCollection,
              updated_at: Time.current,
              feed: []
            )
          )
        get(path)
      end

      specify { expect(response).to be_ok }
    end
  end
end
