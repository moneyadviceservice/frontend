namespace :karma do
  desc 'Create the custom require_config for running local tests'
  task :precompile_require_config => :environment do
    require_config = Rails.application.assets['require_config.js'].to_s

    # Modify asset path
    require_config.gsub!(/\'\/assets\//, 'vendor/assets/bower_components/')

    # Tidy excess empty lines
    require_config.gsub!(/^\n{2,}/, '')

    DEST_DIR = File.join(Rails.root, 'dist')
    DEST_FILE = File.join(DEST_DIR, 'require_config.js')

    Dir.mkdir(DEST_DIR) unless Dir.exists?(DEST_DIR)
    file = File.new(DEST_FILE, 'w')
    file.write(require_config)
    file.close
  end
end
