class CorporateController < ArticlesController
  decorates_assigned :article, with: CorporateDecorator

  private

  def interactor
    Core::CorporateReader.new(params[:id])
  end
end
