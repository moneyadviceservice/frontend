Warden::Manager.after_set_user :except => :fetch do |record, warden, options|
  if warden.authenticated?(options[:scope])
    Delayed::Job.enqueue(Jobs::UpdateUser.new(record.id),
                         queue: 'frontend_crm')
    Devise::Utils.purge_custom_messages(warden.env['rack.session'])
  end
end
