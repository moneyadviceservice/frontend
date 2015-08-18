module Core::Repository
  module HomePages
    class Static
      def find(id)
        hash = {
          slug: 'the-money-advice-service',
          title: 'The Money Advice Service',
          heading: I18n.t('home.show.heading'),
          bullet_1: I18n.t('home.show.trust_banner_list')[0][:text],
          bullet_2: I18n.t('home.show.trust_banner_list')[1][:text],
          bullet_3: I18n.t('home.show.trust_banner_list')[2][:text],
          cta_text: I18n.t('home.show.promo_link_text'),
          cta_link: I18n.t('home.show.promo_link_url'),
          hero_image: ActionController::Base.helpers.image_path("campaign/cut-the-costs-of-a-merry-christmas.jpg"),
          tools: I18n.t('home.show.tools').map { |e| e.stringify_keys },
          tiles: I18n.t('home.show.promoted').map { |e| e.stringify_keys },
          text_tiles: I18n.t('home.show.promoted_no_image').map { |e| e.stringify_keys }
        }

        hash[:tiles].each do |tile|
          tile['image'] = ActionController::Base.helpers.image_path("promos/#{tile['image']}")
          tile['label'] = 'blog' if tile['blog'] == true
        end

        hash
      end
    end
  end
end
