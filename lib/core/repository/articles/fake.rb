module Core::Repository
  module Articles
    class Fake
      def initialize(*articles)
        @articles = articles
      end

      def find(id)
        @articles.find { |article| article['id'] == id }
      end
    end
  end
end
