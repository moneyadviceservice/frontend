module Referer
  extend ActiveSupport::Concern

  included do
    helper_method :referer
  end

  def referer
    return if (http_referer = request.env["HTTP_REFERER"]).blank?

    uri = URI.parse(http_referer)

    return nil unless uri.host.match(internal_domain_regexp)

    uri.to_s
  rescue
    nil
  end

  private

  def internal_domain_regexp
    /(\A|\.)moneyadviceservice\.org\.uk\z/
  end
end
