class AgreementsController < MountController
  private

  def alternate_engine_id
    'agreements'
  end

  protected

  def exclude_syndicated_iframe_resizer?
    false
  end
  helper_method :exclude_syndicated_iframe_resizer?
end
