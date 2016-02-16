require_relative './shared_examples/display_sticky_newsletter_spec'

RSpec.describe StickyNewsletterVisibility, type: :helper do
  let(:request) { double('request', url: url, base_url: base_url) }
  let(:base_url) { 'http://example.com'  }

  describe 'whitelisted' do
    context 'article' do
      let(:url) { 'http://example.com/en/articles/saving-money' }

      it 'displays sticky newsletter' do
        expect(display_sticky_newsletter?).to be(true)
      end
    end
  end

  describe '#black_listed?' do
    context 'sensitive article' do
      let(:url) { 'http://example.com/en/articles/choosing-your-executor' }

      it_behaves_like 'shuns_sticky_newsletter'
    end

    context 'cross-domain blog page' do
      let(:url) { 'http://example.com/blog' }

      it_behaves_like 'shuns_sticky_newsletter'
    end

    %w(en cy).each do |locale|
      context 'home page' do
        let(:url) { "http://example.com/#{locale}" }

        it_behaves_like 'shuns_sticky_newsletter'
      end

      context 'category slugs' do
        let(:url) { "http://example.com/#{locale}/categories/insurance" }

        it_behaves_like 'shuns_sticky_newsletter'
      end

      context 'corporate slugs' do
        let(:url) { "http://example.com/#{locale}/corporate/" }

        it_behaves_like 'shuns_sticky_newsletter'
      end

      context 'tools slugs' do
        let(:url) { "http://example.com/#{locale}/tools/" }

        it_behaves_like 'shuns_sticky_newsletter'
      end

      context 'videos slugs' do
        let(:url) { "http://example.com/#{locale}/videos/" }

        it_behaves_like 'shuns_sticky_newsletter'
      end

      context 'corporate_categories slugs' do
        let(:url) { "http://example.com/#{locale}/corporate_categories/" }

        it_behaves_like 'shuns_sticky_newsletter'
      end

      context 'sitemap slugs' do
        let(:url) { "http://example.com/#{locale}/sitemap" }

        it_behaves_like 'shuns_sticky_newsletter'
      end

      context 'users slugs' do
        let(:url) { "http://example.com/#{locale}/users" }

        it_behaves_like 'shuns_sticky_newsletter'
      end
    end
  end
end
