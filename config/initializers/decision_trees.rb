DecisionTrees.parent_controller = '::EmbeddedToolsController'

DecisionTrees.advice_plans_url = lambda do |locale, codes|
  tool_id = 'health-check'
  mapped_codes = codes.map { |c| "codes[]=#{c}" }.join('&')

  "/#{locale}/tools/#{tool_id}/plans/configure?#{mapped_codes}"
end
