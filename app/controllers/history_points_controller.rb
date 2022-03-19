class HistoryPointsController < ApplicationController
  def index
    render json: current_user.history_points, status: :ok
  end
end
