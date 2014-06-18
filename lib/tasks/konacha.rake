namespace 'spec' do
  desc 'Run the code examples in spec/javascript'
  task :javascript => :environment do
    exit 1 unless ::Konacha.run
  end
end

task(:spec).enhance ['spec:javascript']
