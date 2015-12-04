module Core::Repository::HomePages
  RSpec.describe Static do
    describe '#find' do
      it 'returns the home page' do
        tested = subject.find('the-money-advice-service')

        expect(tested[:slug]).to eql("the-money-advice-service")
        expect(tested[:title]).to eql("The Money Advice Service")
        expect(tested[:heading]).to eql(I18n.t('home.show.heading'))

        expect(tested[:bullet_1]).to eql(I18n.t('home.show.trust_banner_list')[0][:text])
        expect(tested[:bullet_2]).to eql(I18n.t('home.show.trust_banner_list')[1][:text])
        expect(tested[:bullet_3]).to eql(I18n.t('home.show.trust_banner_list')[2][:text])

        expect(tested[:cta_text]).to eql(I18n.t('home.show.promo_link_text'))
        expect(tested[:cta_link]).to eql(I18n.t('home.show.promo_link_url'))

        expect(tested[:hero_image]).to eql('/assets/campaign/cut-the-costs-of-a-merry-christmas.jpg')

        expect(tested[:tools]).to be_an(Array)
        expect(tested[:tiles]).to be_an(Array)
        expect(tested[:text_tiles]).to be_an(Array)

        tested[:tiles].each do |tile|
          expect(tile['image']).to match(/^\/assets\/promos\/.*\.jpg$/)
        end
      end
    end
  end
end
