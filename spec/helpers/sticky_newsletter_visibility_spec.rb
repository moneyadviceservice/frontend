RSpec.describe StickyNewsletterVisibility, type: :helper do
  let(:request) { double('request', url: url, base_url: base_url) }
  let(:base_url) { 'http://example.com'  }

  describe '#display_sticky_newsletter?' do
    context 'articles page' do
      context 'when blacklisted article' do
        let(:url) { 'http://example.com/en/articles/choosing-your-executor' }

        it 'does not show sticky newsletter' do
          expect(display_sticky_newsletter?).to be(false)
        end
      end

      context 'when is not a blacklisted article' do
        let(:url) { 'http://example.com/en/articles/saving-money' }

        it 'displays sticky newsletter' do
          expect(display_sticky_newsletter?).to be(true)
        end
      end
    end

    %w(en cy).each do |locale|
      context 'home page' do
        let(:url) { "http://example.com/#{locale}" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end

      context 'category slugs' do
        let(:url) { "http://example.com/#{locale}/categories/insurance" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end

      context 'corporate slugs' do
        let(:url) { "http://example.com/#{locale}/corporate/" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end

      context 'tools slugs' do
        let(:url) { "http://example.com/#{locale}/tools/" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end

      context 'videos slugs' do
        let(:url) { "http://example.com/#{locale}/videos/" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end

      context 'corporate_categories slugs' do
        let(:url) { "http://example.com/#{locale}/corporate_categories/" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end

      context 'sitemap slugs' do
        let(:url) { "http://example.com/#{locale}/sitemap" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end

      context 'users slugs' do
        let(:url) { "http://example.com/#{locale}/users" }

        it 'excludes in any language' do
          expect(display_sticky_newsletter?).to be false
        end
      end
    end
  end
end
