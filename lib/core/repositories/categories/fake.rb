module Core::Repositories
  module Categories
    class Fake
      def all
        categories
      end

      def find(id)
        category = find_category(categories, id)
        translate_keys(category) if category
      end

      private

      def categories
        [{
          'id' => 'category-1',
          'title' => 'Category 1',
          'subCategories' => [{
            'id' => 'subcategory-1',
            'title' => 'Subcategory 1',
            'subCategories' => [{
              'id' => 'subcategory-2',
              'title' => 'Subcategory 2',
              'subCategories' => []
            }]
          }]
        },{
          'id' => 'category-2',
          'title' => 'Category 2',
          'subCategories' => []
        }]
      end

      def find_category(all_categories, id)
        all_categories.each do |category|
          return category if category['id'] == id
          subcategory = find_category(category['subCategories'], id)
          return subcategory if subcategory
        end
        nil
      end

      # individual categories store child items under 'contents' rather than 'subCategories'
      def translate_keys(category)
        category.dup.tap do |c|
          c['contents'] = c['subCategories'].map { |sub| translate_keys(sub) }
          c.delete('subCategories')
        end
      end
    end
  end
end
