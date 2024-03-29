Warden::Manager.after_set_user :except => :fetch do |record, warden, options|
  if warden.authenticated?(options[:scope])
    Devise::Utils.purge_custom_messages(warden.env['rack.session'])
  end
end
