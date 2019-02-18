class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    last_sales_path
  end
end
