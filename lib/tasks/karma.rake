namespace 'spec' do
  desc 'Run the code examples in spec/javascript'
  task :javascript => ['karma:install', 'karma:run_once']
end

task(:spec).enhance ['spec:javascript']
