Warden::Manager.after_set_user :except => :fetch do |record, warden, options|
  if warden.authenticated?(options[:scope])
    Core::Interactors::UserUpdater.new(record).call
  end
end
