class PurchasesController < ApplicationController
  PURCHASE_HISTORY_POINT_TYPE = 1
  def create
    price = params[:price]
    final_points = price * 3
    @point_history = current_user.history_points.new(history_type: PURCHASE_HISTORY_POINT_TYPE, purchase_price: price, points: final_points, category: params[:category])
    current_user.points += final_points
    if @point_history.save && current_user.save
      render json: { updated_points: current_user.points }, status: :ok
    else
      render json: @point_history.errors.full_messages, status: :unprocessable_entity
    end
  end
end
