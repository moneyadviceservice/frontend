RSpec.describe 'PACS', type: :request do
  ["/en/tools/#{ToolMountPoint::Pacs::EN_ID}",
   "/cy/tools/#{ToolMountPoint::Pacs::CY_ID}"].each do |path|
    describe path do
      let!(:results_double) do
        instance_double(
          Pacs::Results,
          cached: false,
          partials: ['partials-1'],
          updated_at: nil
        )
      end

      before do
				allow(Pacs::Results).to receive(:new).and_return(results_double)
				allow(results_double).to receive(:retrieve).and_return(results_double)
        expect(Pacs::PaymentAccountCollection).to receive(:latest)
          .and_return(double(payment_accounts: []))
        get(path)
      end

      specify { expect(response).to be_ok }
    end
  end
end
