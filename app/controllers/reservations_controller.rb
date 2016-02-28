class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reservations = Reservation.all # need to scope this
  end

  def new
    @playday = Playday.friendly.find(params[:playday_id])
    @reservation = Reservation.new
  end

  def create
    if current_user.nil?
      session[:list] = params
      redirect_to new_user_registration_path
    else
      @playday = Playday.friendly.find(params[:playday_id])
      @reservation = @playday.reservations.new(reservation_params)
      @reservation.user = current_user
      @reservation.date = @playday.date

      if @reservation.save
        update_playday_timeslots
        flash[:notice] = "Reservation was saved."
        redirect_to [@playday, @reservation]
      else
        flash.now[:alert] = "There was an error saving the reservation. Please try again."
        render :new
      end
    end
  end

  def edit
    @playday = Playday.friendly.find(params[:id])
    @reservation = Reservation.find(params[:id])
  end

  def update
  end

  def show
    @reservation = Reservation.last
  end

  def delete
  end
end

private

def update_playday_timeslots
  @playday.update(seven_am: 99)
end


def reservation_params
  params.require(:reservation).permit(:six_hundred, :eight_hundred, :date, :time, :photo, :discount, :playday_id )
end
