JSHINTRC_LOCATION = 'vendor/assets/bower_components/dough/.jshintrc'

desc 'Run jshint on all javascript assets'
task :jshint => :environment do
  # Prevent linting as part of the asset pipeline
  Rails.application.assets.instance_variable_get('@postprocessors')['application/javascript'].delete(AssetPipeline::Processors::JsHint)

  jshintrc = File.join(Rails.root, JSHINTRC_LOCATION)
  lint_options = JSON.parse(File.read(jshintrc))

  assets = [].tap do |a|
    Rails.application.assets.each_file do |pathname|
      if pathname.to_s =~ AssetPipeline::Processors::JsHint::REGEX
        a << pathname
      end
    end
  end

  assets.each do |pathname|
    js = Rails.application.assets[pathname]
    results = JshintRuby.run(js.to_s, lint_options)

    puts pathname

    errors = results.errors.compact

    if errors.present?
      errors.sort! { |a, b| [a['line'], a['character']] <=> [b['line'], b['character']] }

      errors.each do |error|
        puts "- line: #{error['line']}, char: #{error['character']}: #{error['reason']}"
      end
    else
      puts '- no errors'
    end

    puts '---' unless pathname == assets.last
  end
end
