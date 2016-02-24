module Core
  class Contact
    include ActiveModel::Model
    attr_accessor :heading, :introduction, :phone_number, :additional_one,
                  :additional_two, :additional_three, :small_print
  end
end
