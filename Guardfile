guard :bundler do
  watch('Gemfile')
end

guard :cucumber, cmd: 'spring cucumber', all_on_start: false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

guard :livereload do
  watch(%r{^app/.+\.(erb|haml|js|css|scss|sass|coffee|eco|png|gif|jpg)})
  watch(%r{^app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{^config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(erb|haml|js|css|scss|sass|coffee|eco|png|gif|jpg))).*}) { |m| "/assets/#{m[3]}" }
end

guard :rails, cmd: 'spring rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

guard :rspec, cmd: 'spring rspec', all_on_start: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }

  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| %W(spec/routing/#{m[1]}_routing_spec.rb spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb spec/acceptance/#{m[1]}_spec.rb) }
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
  watch('config/routes.rb') { 'spec/routing' }
  watch('app/controllers/application_controller.rb') { 'spec/controllers' }
end

guard :shell do
  watch('bower.json') { `bower install` }
end
