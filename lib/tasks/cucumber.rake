begin
  require 'cucumber/rake/task'

  # cucumber tasks are also defined in some of the the engines causing
  # the features to be run multiple times, delete these duplicates
  tasks = Rake.application.instance_variable_get('@tasks')
  tasks.reject! { |task, deps| task =~ /cucumber/ }

  namespace :cucumber do
    ::Cucumber::Rake::Task.new({ ok: 'test:prepare' },
                               'Run features that should pass') do |t|
      t.fork    = true # You may get faster startup if you set this to false
      t.profile = 'default'
    end

    ::Cucumber::Rake::Task.new({ wip: 'test:prepare' },
                               'Run features that are being worked on') do |t|
      t.fork    = true # You may get faster startup if you set this to false
      t.profile = 'wip'
    end

    ::Cucumber::Rake::Task.new({ rerun: 'test:prepare' },
                               'Record failing features and run only them if any exist') do |t|
      t.fork    = true # You may get faster startup if you set this to false
      t.profile = 'rerun'
    end

    desc 'Run all features'
    task :all => [:ok, :wip]
  end

  desc 'Alias for cucumber:ok'
  task cucumber: 'cucumber:ok'
rescue LoadError
end
