class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Report.ransack(params[:q])
    @reports = @q.result
  end

  def new
    @report = Report.new
  end
end
