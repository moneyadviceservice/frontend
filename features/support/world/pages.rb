module World
  module Pages
    %w().each do |page|
      define_method("#{page}_page") do
        "UI::#{page.camelize}::Page".constantize.new
      end
    end
  end
end

World(World::Pages)
