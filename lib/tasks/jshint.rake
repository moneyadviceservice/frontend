desc 'Run jshint on all javascript assets'
task :jshint => :environment do
  # Prevent linting as part of the asset pipeline
  Rails.application.assets.instance_variable_get('@postprocessors')['application/javascript'].delete(AssetPipeline::Processors::JsHint)

  jshintrc = File.join(Rails.root, '.jshintrc')
  lint_options = JSON.parse(File.read(jshintrc))

  Rails.application.assets.each_file do |pathname|
    if pathname.to_s =~ /\.js\z/
      js = Rails.application.assets[pathname]
      results = JshintRuby.run(js.to_s, lint_options)

      puts pathname

      errors = results.errors.compact.sort_by { |error| error['line'] }
      if errors.present?
        puts '- errors:'
        errors.compact.each do |error|
          puts "  line: #{error['line']}, char: #{error['character']}: #{error['reason']}"
        end
      else
        puts '- no errors'
      end
    end
  end
end
