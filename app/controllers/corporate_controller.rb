class CorporateController < ArticlesController
  before_action :authenticate, if: -> { Authenticable.required? }, only: :export_partners
  decorates_assigned :article, with: CorporateDecorator
  decorates_assigned :category, with: CorporateCategoryDecorator

  def index
    @category = retrieve_corporate_category
    assign_active_categories(@category)
  end

  def show
    super
    retrieve_syndication_tools
    retrieve_corporate_category
    set_corporate_category
    assign_active_categories(retrieve_corporate_category)
    @partner = CorporatePartner.new
  end

  def create
    @partner = CorporatePartner.new(partner_params)
    @partner.tool_name = tool_friendly_name

    if @partner.save
      flash[:success] = t('tool_page.form.success_flash')
      flash[:partner] = @partner
      redirect_to corporate_path(params[:id], anchor: 'your-embed-code')
    else
      @article = interactor.call
      retrieve_corporate_category
      set_corporate_category
      assign_active_categories(retrieve_corporate_category)
      set_related_content
      render :show
    end
  end

  def export_partners
    @corporate_partners = CorporatePartner.all
    csv = @corporate_partners.to_csv
    send_data csv,
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: 'attachment',
              filename: "corporate_partners-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv"
  end

  private

  def retrieve_corporate_category
    @corporate_category ||= Core::CategoryReader.new('corporate-home').call
  end

  def set_corporate_category
    @category = @article.categories.last
  end

  def retrieve_syndication_tools
    @syndication_tools ||= Core::CategoryReader.new('syndication').call
  end

  def interactor
    Core::CorporateReader.new(params[:id])
  end

  def category_tree(categories)
    Core::CategoryTreeReader.new.call(categories)
  end

  def partner_params
    params.require(:corporate_partner).permit(:name, :email, :tool_language, :tool_width_unit, :tool_width)
  end

  def tool_friendly_name
    params[:id].chomp('-syndication').gsub('-', ' ').humanize
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      Authenticable.authenticate(username, password)
    end
  end
end
