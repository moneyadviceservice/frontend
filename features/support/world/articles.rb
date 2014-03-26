module World
  module Articles
    def current_article_in(locale)
      case locale
        when 'en'
          @current_article_en ||= build(:article,
            id:          'why-it-pays-to-save-regularly',
            title:       'Why it pays to save regularly',
            description: 'A regular savings habit makes your savings grow fast – getting started is quick and easy',
            body:        'If you save regularly, you’ll quickly find that your savings add up and keep growing. Get into the habit and watch your money turn into more money.')
        when 'cy'
          @current_article_cy ||= build(:article,
            id:          'pam-bod-cynilon-rheolaidd-yn-talu-ffordd',
            title:       "Pam bod cynilo'n rheolaidd yn talu ffordd",
            description: "Mae mynd i'r arfer o gynilo'n rheolaidd yn golygu y bydd eich cynilion yn tyfu'n gyflym – mae'n gyflym ac yn hawdd dechrau arni",
            body:        "Os byddwch yn cynilo'n rheolaidd, buan y byddwch yn ychwanegu at eich cynilion ac y byddant yn parhau i dyfu. Ewch i'r arfer a gwyliwch wrth i'ch arian droi'n fwy o arian.")
      end
    end
  end
end

World(World::Articles)
