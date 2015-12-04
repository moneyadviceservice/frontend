class HomePagesPreviewController < HomeController
  private

  def interactor
    Core::HomePagePreviewer.new('the-money-advice-service')
  end
end
