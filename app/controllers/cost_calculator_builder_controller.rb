class CostCalculatorBuilderController < MountController
  protected

  def category_id
    'cost-calculator-builder'
  end

  # Note: syndicated_tool_request? is overridden in the engine.
  #        This tool isn't served on the partner-tools subdomain,
  #       so syndicated requests can't be detected using the usual
  #       process of looking for the 'X-Syndicated-Tool' header.
  def parent_template
    if syndicated_tool_request?
      'layouts/engine_syndicated'
    else
      'layouts/engine_unconstrained'
    end
  end

  def contact_panels_border_top?
    false
  end

  def alternate_engine_id
    send "#{alternate_locale}_engine_id"
  end

  helper_method :alternate_options

  def en_engine_id
    EngineMountPoint::CostCalculatorBuilder::EN_ID
  end

  def cy_engine_id
    EngineMountPoint::CostCalculatorBuilder::CY_ID
  end
end
