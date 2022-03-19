class PurchasesController < ApplicationController
  PURCHASE_HISTORY_POINT_TYPE = 1
  def create
    price = params[:price]
    final_points = price * 3
    @point_history = current_user.history_points.create(history_type: PURCHASE_HISTORY_POINT_TYPE, purchase_price: price, points: final_points, category: params[:category])
  end
end
