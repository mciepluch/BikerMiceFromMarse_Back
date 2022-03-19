class UsersPrizesController < ApplicationController
  before_action :set_user_prize, only: %i[show destroy update]

  def index
    page = params[:page] || 1
    current_records = current_user.users_prizes.page(page).per(15)
    render json: { resources: current_records, total: current_records.total_pages, current_page: current_records.current_page }, status: :ok
  end

  def create
    new_prize = current_user.users_prizes.new(user_prize_params_create)
    current_user.points -= Prize.find(params[:user_prize][:prize_id]).price
    unless current_user.points.positive?
      render status: :forbidden
      return
    end
    if new_prize.save && current_user.save
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def update
    if @prize.update(user_prize_params_update)
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def show
    render json: @prize, status: :ok
  end

  def destroy
    if @prize.destroy
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def set_user_prize
    @prize = current_user.users_prizes.find(params[:id])
  end

  def user_prize_params_create
    params.require(:user_prize).permit(:prize_id, :duration_left)
  end

  def user_prize_params_update
    params.require(:user_prize).permit(:duration_left)
  end
end