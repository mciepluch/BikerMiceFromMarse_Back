class PointsController < ApplicationController
  def update_points
    current_user.points += params[:points]
    current_user.save
  end
end
