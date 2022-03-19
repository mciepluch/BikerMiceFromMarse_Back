class PointsController < ApplicationController
  def update_points
    current_user.points += params[:points]
    @point_history = current_user.history_points.create(points: params[:points])
    if @point_history.save && current_user.save
      render status: 200
    else
      render status: 422
    end
  end
end
