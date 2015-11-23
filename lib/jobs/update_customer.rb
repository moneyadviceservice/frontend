module Jobs
  UpdateFromCustomer = Struct.new(:user_id) do
    def perform
      user = User.find(user_id)
      Core::Interactors::Customer::Updater.new(user).call
    end
  end
end
