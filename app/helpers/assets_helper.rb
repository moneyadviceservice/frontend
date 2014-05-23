require 'assets/optimizely_script'

module AssetsHelper
  CACHE_EXPIRY = 150.seconds

  def optimizely_include_tag
    Rails.cache.fetch('optimizely_script', expires_in: CACHE_EXPIRY, race_condition_ttl: 100) do
      Assets::OptimizelyScript.new.to_s.html_safe
    end
  end
end
