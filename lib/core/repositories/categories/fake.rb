module Core::Repositories
  module Categories
    class Fake
      def all
        categories
      end

      def find(id)
        categories.find { |category| category['id'] == id }
      end

      private

      def categories
        [{
          'id' => 'category-1',
          'title' => 'Category 1',
          'subCategories' => [
            'id' => 'subcategory-1',
            'title' => 'Subcategory 1',
            'subCategories' => []
          ]
        },{
          'id' => 'category-2',
          'title' => 'Category 2',
          'subCategories' => []
        }]
      end
    end
  end
end
