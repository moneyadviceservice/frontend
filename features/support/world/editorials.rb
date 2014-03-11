module World
  module Editorials
    def current_editorial(editorial_name)
      underscore_editorial = underscore(editorial_name)
      send("current_#{underscore_editorial}")
    end

    def editorial_page(editorial_name)
      underscore_editorial = underscore(editorial_name)
      send("#{underscore_editorial}_page")
    end
  end
end


World(World::Editorials)
