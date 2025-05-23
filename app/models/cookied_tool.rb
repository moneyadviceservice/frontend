class CookiedTool
  attr_accessor :landing_path, :tool, :canonical_url

  def initialize(landing_path:, tool:, canonical_url:)
    @landing_path = landing_path
    @tool = tool
    @canonical_url = canonical_url
  end

  def landing_path_regex
    %r{^#{landing_path}?$}
  end

  COOKIED_TOOLS = [
    CookiedTool.new(
      landing_path: '/en/tools/credit-card-calculator/credit-card/',
      tool: 'credit-card-calculator',
      canonical_url: 'https://www.moneyhelper.org.uk/en/everyday-money/credit-and-purchases/use-our-credit-card-calculator'
    ),
    CookiedTool.new(
      landing_path: '/en/tools/loan-calculator/loan/',
      tool: 'loan-calculator',
      canonical_url: 'https://www.moneyhelper.org.uk/en/everyday-money/credit-and-purchases/use-our-loan-calculator'
    ),
    CookiedTool.new(
      landing_path: '/en/tools/workplace-pension-contribution-calculator/',
      tool: 'wpcc',
      canonical_url: 'https://www.moneyhelper.org.uk/en/pensions-and-retirement/auto-enrolment/use-our-workplace-pension-calculator'
    )
  ].freeze

  def self.find_by_landing_path(path)
    COOKIED_TOOLS.find { |tool| tool.landing_path_regex === path }
  end

  def self.find_by_tool(id)
    COOKIED_TOOLS.find { |tool| tool.tool == id }
  end
end
