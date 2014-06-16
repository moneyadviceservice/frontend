desc 'Generate Sitemap CSV'
task :sitemap => :environment do

  require 'core/connection_factory'
  require 'csv'

  connection = Core::ConnectionFactory.build('https://www.moneyadviceservice.org.uk')
  categories = connection.get('/en/categories.json').body

  CSV.open('tmp/sitemap.csv', 'wb') do |csv|
    csv << ['Category', 'Sub-Category', 'Item']

    categories.each do |category|
      title    = category['title']
      contents = category['contents']

      contents.each do |item|
        sub_category = connection.get("/en/categories/#{item['id']}.json").body

        sub_category['contents'].each do |sub_item|
          csv << [title, sub_category['title'], sub_item['title']]
        end
      end
    end
  end

end
