class TravelSessionsController < ApplicationController
  POINTS_MULTIPLY = 10
  TRAVEL_HISTORY_POINT_TYPE = 0

  def index
    if current_user.travel_session
      render json: current_user.travel_session, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def create
    unless current_user.travel_session
      travel_session = current_user.create_travel_session(travel_session_create_params)
      if travel_session.save
        render json: travel_session, status: :created
        return
      end
    end

    render status: :unprocessable_entity
  end

  def update
    travel_session = current_user.travel_session
    if travel_session && travel_session.update(travel_session_update_params)
      points = (travel_session.end_station - travel_session.start_station) * POINTS_MULTIPLY
      final_points = points.positive? ? points : -points
      @point_history = current_user.history_points.create(history_type: TRAVEL_HISTORY_POINT_TYPE, points: final_points, start_datetime: travel_session.created_at, category: travel_session.travel_tool, start_station: travel_session.start_station, end_station: travel_session.end_station)
      current_user.points += final_points
      if @point_history.save && travel_session.destroy && current_user.save
        render status: :ok
        return
      end
    end
    render status: :unprocessable_entity
  end

  def delete
    if current_user.travel_session && cucurrent_user.travel_session.destroy
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def travel_session_create_params
    params.require(:travel_session).permit(:start_station, :travel_tool)
  end

  def travel_session_update_params
    params.require(:travel_session).permit(:end_station)
  end
end
