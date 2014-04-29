config     = Rails.root.join('config', 'features.yml')
repository = if File.exist?(config)
               Feature::Repository::YamlRepository.new(config)
             else
               Feature::Repository::SimpleRepository.new
             end

Feature.set_repository(repository)
