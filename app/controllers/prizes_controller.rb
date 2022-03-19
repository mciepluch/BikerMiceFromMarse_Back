class PrizesController < ApplicationController
  before_action :set_prize, only: %i[update show destroy]

  def index
    page = params[:page] || 1
    current_records = Prize.all.page(page).per(15)
    render json: { users_prizes: current_records, total: current_records.total_pages, current_page: current_records.current_page }, status: :ok
  end

  def create
    prize = Prize.create(prize_params)
    if prize.save
      render json: prize, status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def show
    render json: @prize, status: :ok
  end

  def update
    if @prize.update(prize_params)
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    if @prize.destroy
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def prize_params
    params.require(:prize).permit(:title, :price, :duration)
  end

  def set_prize
    @prize = Prize.find(params[:id])
  end
end
