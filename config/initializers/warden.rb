Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_scope = :user
end

Warden::Manager.serialize_from_session do |id|
  User.new(id.first.first)
end
