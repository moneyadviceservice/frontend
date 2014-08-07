module Devise
  class FailureAppWithCustomFlash < FailureApp
    def recall
      flash.now[:error] = i18n_message(:invalid)
      super
    end
  end
end
