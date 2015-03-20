require_relative 'config/application'
include FileUtils

Rails.application.load_tasks

Rake::Task['assets:precompile'].enhance do
  Rake::Task[:copy_precompiled_tools_js].invoke
end

private

desc 'copy tools_<hash_asset_id>.js to tools.js for embedded tools'
task :copy_precompiled_tools_js do
  precompiled_file_paths = Dir.glob(File.join('public', assets_dir_name, 'syndication', 'tools*js'))
  source_path = precompiled_most_recent_tools_js(precompiled_file_paths)
  if source_path.present?
    tools_js_location = File.join('public', assets_dir_name, 'syndication', 'tools.js')
    if update_tools_js?(source_path, tools_js_location)
      FileUtils.cp(source_path, tools_js_location)
    end
  end
end

def assets_dir_name
  Rails.application.config.assets.prefix
end

def precompiled_most_recent_tools_js(file_paths)
  files_found = file_paths.map { |path| File.new(Rails.root.join(path)) }
  sorted_results = files_found.sort { |file1, file2| file2.stat <=> file1.stat }
  sorted_results.first
end

def update_tools_js?(precompiled_tools_js, tools_js_location)
  !File.exist?(tools_js_location) ||
  (File.exist?(tools_js_location) && !FileUtils.identical?(precompiled_tools_js, tools_js_location))
end
