module Core
  class HomePage < Entity
    Alternate = Struct.new(:title, :url, :hreflang)

    # TODO remove a few of these
    attr_accessor :type, :slug, :identifier, :title, :description, :body,
                  :categories, :related_content, :promo,
                  :heading, :hero_image,
                  :bullet_1, :bullet_2, :bullet_3,
                  :cta_text, :cta_link,
                  :tiles, :tools, :text_tiles,
                  :promo_banner_url, :promo_banner_content

    attr_reader :alternates

    validates_presence_of :title

    def alternates=(alternates)
      @alternates = alternates.map do |alternate|
        Alternate.new(*alternate.values_at(:title, :url, :hreflang))
      end
    end
  end
end
