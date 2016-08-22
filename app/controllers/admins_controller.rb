class AdminsController < ApplicationController
  before_action :validate_date_range, only: :export_file

  def export_file
    @experiments = ExperimentSession.created_between(
      params[:start_date],
      params[:end_date]
    )
    if @experiments.present?
      respond_to do |format|
        format.xlsx {
          response.headers['Content-Disposition'] =
            'attachment; filename="experiments_data.xlsx"'
        }
      end
    else
      flash.now[:error] = 'No data found'
      render 'query_data.html.erb'
    end
  end

  private

  def validate_date_range
    error = nil
    if params[:start_date].blank? || params[:end_date].blank?
      error = 'Both dates are required'
    else
      return unless params[:end_date] < params[:start_date]
      error = 'The end date cannot be earlier than the start date'
    end
    return if error.nil?
    flash.now[:error] = error
    render :query_data
  end

end
