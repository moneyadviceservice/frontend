require 'asset_pipeline/processors/js_hint'
require 'asset_pipeline/processors/css_lint'

Rails.application.assets.register_postprocessor('application/javascript', AssetPipeline::Processors::JsHint)
Rails.application.assets.register_postprocessor('text/css', AssetPipeline::Processors::CssLint)
