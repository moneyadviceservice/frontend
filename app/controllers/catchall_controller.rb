class CatchallController < ApplicationController
  def not_implemented
    interactor.call do |error|
      if error.redirect?
        return redirect_to error.location, status: error.status
      end
    end

    raise ActionController::RoutingError.new('Not Found')
  rescue Core::Repository::Base::RequestError => e
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def interactor
    Core::RedirectReader.new(path)
  end

  def path
    if params[:format]
      params[:path] + "." + params[:format]
    else
      params[:path]
    end
  end
end
