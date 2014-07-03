module Core::Repository
  module Categories
    class Fake
      def initialize(*categories)
        @categories = (categories.present?) ? categories : default_categories
      end

      def all
        remove_non_categories(@categories)
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
          'parent_id' => nil,
          'contents' => [{
            'id' => 'subcategory-1',
            'title' => 'Subcategory 1',
            'type' => 'category',
            'parent_id' => 'category-1',
            'contents' => []
          },{
            'id' => 'subcategory-2',
            'type' => 'category',
            'title' => 'Subcategory 2',
            'contents' => []
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
          subcategory = find_category(category.fetch('contents', []), id)
          return subcategory if subcategory
        end
        nil
      end

      def remove_non_categories(items)
        items.select { |c| c.member? 'contents' }.map do |category|
          category.dup.tap do |c|
            c['contents'] = remove_non_categories(c['contents'])
          end
        end
      end
    end
  end
end
