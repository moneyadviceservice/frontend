RSpec.describe 'shared/_article_promos', type: :view do
  before do
    allow(view).to receive(:items_with_image) do
      [
        {
          'heading' => 'Plug those money leaks',
          'image' => 'https://example.com/MoneyLeaks.jpg',
          'url' => 'https://example.com/blog',
          'label' => 'blog',
          'content' => 'Do you know the most common ways you waste money?'
        }
      ]
    end

    allow(view).to receive(:items_without_image) do
      [
        {
          'heading' => 'Estimate the cost of buying a house and moving',
          'url' => 'https://example.com/blog',
          'content' => 'There is more to it than just mortgage repayments'
        }
      ]
    end

    render
  end

  context 'srcset size settings' do
    specify { expect(rendered).to include(t('api.settings.viewport_config')) }
  end
end
