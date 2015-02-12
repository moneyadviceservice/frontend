class CorporateController < ArticlesController
  private

  def interactor
    Core::CorporateReader.new(params[:id])
  end
end
