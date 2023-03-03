RSpec.describe 'Cookied tool checks', type: :request do
  context 'when cookies are enabled' do
    CookiedTool::COOKIED_TOOLS.each do |tool|
      context "when viewing the landing page `#{tool.landing_path}`" do
        it 'verifies cookies are enabled and shows the tool' do
          get tool.landing_path

          # the landing page checks it can set the `checked` cookie
          expect(response).to redirect_to(%r{/en/cookies_disabled?.*tool=#{tool.tool}})
          expect(cookies['checked']).to eq('true')

          # after verifying the cookie was written it redirects back with the flag set
          get "/en/cookies_disabled?tool=#{tool.tool}"
          expect(response).to redirect_to("#{tool.landing_path}?checked=true")
        end
      end
    end
  end

  context 'when cookies are disabled' do
    CookiedTool::COOKIED_TOOLS.each do |tool|
      context "when setting a cookie fails for the path `#{tool.landing_path}`" do
        it 'shows a link to the MoneyHelper hosted tool instead' do
          get "/en/cookies_disabled?tool=#{tool.tool}"

          expect(response.body).to include(tool.canonical_url)
        end
      end
    end
  end
end
