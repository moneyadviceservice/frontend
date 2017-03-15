RSpec.describe 'shared/_article_promos', type: :view do
  before do
    allow(view).to receive(:items_with_image) do
      [
        {
          'heading' => 'Plug those money leaks',
          'image' => 'https://example.com/MoneyLeaks.jpg',
          'url' => 'https://example.com/blog',
          'label' => 'blog',
          'content' => 'Do you know the most common ways you waste money?',
          'srcset' => 'https://example.com/small/MoneyLeaks.jpg 390w'
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

  it 'includes the image with srcset attributes' do
    #img_tag = %{
    #  <img alt="" sizes="(max-width: 479px) 100vw, (max-width: 959px) 50vw, 25vw" srcset="https://example.com/small/MoneyLeaks.jpg 390w" class="promo__img" src="https://example.com/MoneyLeaks.jpg" />
    #}.strip

    #expect(rendered).to include(img_tag)

    img_tag = <<-CONTENT
      <img alt=""|
					 sizes="(max-width: 479px) 100vw, (max-width: 959px) 50vw, 25vw"|
					 srcset="https://example.com/small/MoneyLeaks.jpg 390w"|
					 class="promo__img"|
					 src="https://example.com/MoneyLeaks.jpg" />
    CONTENT

    expect(rendered).to include(img_tag.split('|').map(&:strip).join(' '))
  end
end
