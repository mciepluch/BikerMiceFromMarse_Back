class TravelSessionsController < ApplicationController
  POINTS_MULTIPLY = 10

  def index
    render json: current_user.travel_session, status: :ok
  end

  def create
    travel_session = current_user.create_travel_session(travel_session_create_params)
    if travel_session.save
      render json: travel_session, status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def update
    travel_session = current_user.travel_session
    if travel_session.update(travel_session_update_params)
      points = (travel_session.end_station - travel_session.start_station) * POINTS_MULTIPLY
      final_points = points.positive? ? points : -points
      @point_history = current_user.history_points.create(points: final_points, start_station: travel_session.start_station, end_station: travel_session.end_station)
      current_user.points += final_points
      if @point_history.save && travel_session.destroy && current_user.save
        render status: :ok
        return
      end
    end
    render status: :unprocessable_entity
  end

  def delete
    if current_user.travel_session.destroy
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def travel_session_create_params
    params.require(:travel_session).permit(:start_station)
  end

  def travel_session_update_params
    params.require(:travel_session).permit(:end_station)
  end
end
