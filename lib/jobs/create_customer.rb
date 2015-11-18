module Jobs
  CreateCustomer = Struct.new(:user_id) do
    def perform
      user = User.find(user_id)
      Core::Interactors::Customer::Creator.new(user).call
    end
  end
end
