class PointsController < ApplicationController
  def update_points
    p current_user
    current_user.points += params[:points]
    current_user.save
  end
end
