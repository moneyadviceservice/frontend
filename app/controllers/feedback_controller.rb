class FeedbackController < MountController

  def display_skip_to_main_navigation?
    false
  end

  private

  def alternate_engine_id
    'improvements'
  end
end
