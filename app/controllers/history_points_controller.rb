class HistoryPointsController < ApplicationController
  def index
    page = params[:page] ? params[:page] : 1
    current_records = current_user.history_points.page(page).per(15)
    render json: { users_prizes: current_records, total: current_records.total_pages, current_page: current_records.current_page }, status: :ok
  end
end
