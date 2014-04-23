require 'faker'
require 'factory_girl'

FactoryGirl.definition_file_paths << File.join(Rails.root, 'features', 'factories')
FactoryGirl.find_definitions

I18n.available_locales = [:en, :cy]

module Core::Repositories
  module Categories
    class Prototype
      def initialize
        yaml = YAML.load(File.read(File.join(Rails.root, 'config', 'categories.yml')))
        @categories = yaml['categories'].map do |c|
          title = c.keys.first
          subcategories = c[title]
          build_category(title, build_subcategories(subcategories))
        end
      end

      def all
        @filtered_categories ||= remove_non_categories(@categories)
      end

      def find(id)
        find_category(@categories, id)
      end

      private

      def build_category(title, contents = [])
        FactoryGirl.build(:category_hash,
          id: title.downcase.gsub(/\W+/, '-'),
          title: title,
          contents: contents)
      end

      def build_subcategories(subcategories)
        subcategories.map do |subcategory|
          build_category(subcategory,
            FactoryGirl.build_list(:article_hash, (rand(4) + 2), id: 'paying-for-a-funeral'))
        end
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
