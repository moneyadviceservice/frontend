module Core::Repositories
  module Categories
    class Fake
      def initialize(*categories)
        @categories = (categories.present?) ? categories : default_categories
      end

      def all
        @categories
      end

      def find(id)
        find_category(@categories, id)
      end

      private

      def default_categories
        [{
          'id' => 'category-1',
          'type' => 'category',
          'title' => 'Category 1',
          'contents' => [{
            'id' => 'subcategory-1',
            'title' => 'Subcategory 1',
            'type' => 'category',
            'contents' => [{
              'id' => 'subcategory-2',
              'type' => 'category',
              'title' => 'Subcategory 2',
              'contents' => []
            }]
          }]
        },{
          'id' => 'category-2',
          'type' => 'category',
          'title' => 'Category 2',
          'contents' => []
        }]
      end

      def find_category(categories, id)
        categories.each do |category|
          return category if category['id'] == id
          subcategory = find_category(category['contents'], id)
          return subcategory if subcategory
        end
        nil
      end
    end
  end
end
