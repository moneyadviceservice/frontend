require 'assets/optimizely_script'

module AssetsHelper
  def optimizely_include_tag
    Assets::OptimizelyScript.new.to_s.html_safe
  end
end
