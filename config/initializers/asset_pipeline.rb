require 'asset_pipeline/processors/js_hint'

Rails.application.assets.register_postprocessor('application/javascript', AssetPipeline::Processors::JsHint)
