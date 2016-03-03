module Core
  class WebChat
    include ActiveModel::Model
    attr_accessor :heading, :additional_one, :additional_two, :additional_three,
                  :small_print
  end
end
