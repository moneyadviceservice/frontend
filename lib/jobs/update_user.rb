module Jobs
  UpdateUser = Struct.new(:user_id) do
    def perform
      user = User.find(user_id)
      Core::Interactors::UserUpdater.new(user).call
    end
  end
end
