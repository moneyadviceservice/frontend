RSpec.describe 'Wpcc', type: :request do
  [ "/en/tools/#{ToolMountPoint::Wpcc::EN_ID}",
    "/cy/tools/#{ToolMountPoint::Wpcc::CY_ID}" ].each do |path|
    describe path do
      context 'when credentials are valid' do
        let(:credentials) do
          ActionController::HttpAuthentication::Basic.encode_credentials(
            ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD']
          )
        end

        before do
          get(path, {}, { 'HTTP_AUTHORIZATION' => credentials })
        end

        specify { expect(response).to be_ok }
      end

      context 'when credentials are invalid' do
        before { get(path) }

        it 'returns unauthorized status' do
          expect(response.status).to be(401)
        end
      end
    end
  end
end
