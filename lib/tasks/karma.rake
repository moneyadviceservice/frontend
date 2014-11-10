namespace :karma  do
  desc 'Install NPM modules'
  task :install => :environment do
    install_modules
  end

  desc 'Run the karma tests continuously'
  task :run => :environment do
    with_tmp_config :start
  end

  desc 'Run the karma tests once'
  task :run_once => :environment do
    with_tmp_config :start, "--single-run"
  end


  def with_tmp_config(command, args = nil)
    $stderr.puts "--------------------------------------------------------------------------------------------"
    $stderr.puts "CAUTION: this rake task only works when run from the immediate parent of your spec directory"
    $stderr.puts "--------------------------------------------------------------------------------------------"
    $stderr.puts

    FileUtils.mkdir('tmp') unless Dir.exists?('tmp')
    Tempfile.open('karma_unit.js', File.expand_path('tmp')) do |f|
      f.write unit_js(application_spec_files)
      f.flush
      sh "./node_modules/karma/bin/karma #{command} #{f.path} #{args}"
    end
  end

  def application_spec_files
    sprockets = Rails.application.assets
    sprockets.append_path File.expand_path("spec/javascripts")
    sprockets.find_asset("application_spec.js").to_a.map {|e| e.pathname.to_s }
  end

  def unit_js(files)
    unit_js = File.open('spec/javascripts/karma.conf.js', 'r').read

    unit_js.gsub "APPLICATION_SPEC", "\"#{files.join("\",\n\"")}\""
  end

  def install_modules
    sh "npm install"
  end
end
