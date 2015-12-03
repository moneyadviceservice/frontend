RSpec.describe StickyNewsletterVisibility, type: :helper do
  let(:request) { double('request')}

  describe 'home page' do
    %w(en cy).each do |locale|
      it 'excludes in any language' do
        allow(request).to receive(:url) { "http://example.com/#{locale}" }
        allow(request).to receive(:base_url) { 'http://example.com' }
        expect(display_sticky_newsletter_on_this_slug?).to be false
      end
    end
  end

  describe 'category slugs' do
    %w(en cy).each do |locale|
      it 'excludes in any language' do
        allow(request).to receive(:url) { "http://example.com/#{locale}/categories/insurance" }
        allow(request).to receive(:base_url) { 'http://example.com' }

        expect(display_sticky_newsletter_on_this_slug?).to be false
      end
    end
  end
end
