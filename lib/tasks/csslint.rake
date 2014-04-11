desc 'Run csslint on all css assets'
task :csslint => :environment do
  # Prevent linting as part of the asset pipeline
  Rails.application.assets.instance_variable_get('@postprocessors')['text/css'].delete(AssetPipeline::Processors::CssLint)

  csslint = File.join(Rails.root, '.csslint')
  lint_options = JSON.parse(File.read(csslint))

  Rails.application.assets.each_file do |pathname|
    if pathname.basename.to_s =~ /\A[^_][a-zA-Z0-9_.]+.scss\z/
      css = Rails.application.assets[pathname]
      results = CsslintRuby.run(css.to_s, lint_options)

      puts pathname

      errors = results.errors.sort_by { |error| error['line'] }
      if errors.present?
        puts '- errors:'
        errors.each do |error|
          puts "  line: #{error['line']}, col: #{error['col']}, message: #{error['message']}: #{error['evidence']}"
          puts "  rule: #{error['rule']['name']}: #{error['rule']['desc']}"
          puts "----------"
        end
      else
        puts '- no errors'
      end
    end
  end
end
