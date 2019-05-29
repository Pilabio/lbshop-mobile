class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Report.ransack(params[:q])
    @reports = @q.result.page(params[:page])
  end

  def new
    @report = ReportForm.new
  end

  def create
    @report = ReportForm.new(permitted_params)

    if @report.generate
      redirect_to reports_path
    else
      render 'new'
    end
  end

  private

  def permitted_params
    params.require(:report_form).permit(:init_date, :end_date, :products_status)
  end
end
