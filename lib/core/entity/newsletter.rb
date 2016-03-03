module Core
  class Newsletter
    include ActiveModel::Model
    attr_accessor :heading, :introduction
  end
end
