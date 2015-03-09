class RioController < MountController
  def parent_template
    'layouts/engine_unconstrained'
  end

  def category_id
    'work-pensions-and-retirement'
  end

  private

  def alternate_engine_id
    send "#{alternate_locale}_engine_id"
  end

  def en_engine_id
    EngineMountPoint::Rio::EN_ID
  end

  def cy_engine_id
    EngineMountPoint::Rio::CY_ID
  end
end
