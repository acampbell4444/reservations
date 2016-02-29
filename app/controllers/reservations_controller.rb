class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reservations = Reservation.all # need to scope this
  end

  def new
    #@playday = Playday.friendly.find(params[:playday_id])
    @reservation = Reservation.new
  end

  def create
    if current_user.nil?
      session[:list] = params
      redirect_to new_user_registration_path
    else
      @reservation = Reservation.new(reservation_params)
      @reservation.user = current_user

      times = {
        "8 am" => "eight_am",
        "9 am" => "nine_am",
        "10 am" => "ten_am",
        "11 am" => "eleven_am",
        "12 pm" => "twelve_pm",
        "1 pm" => "one_pm",
        "2 pm" => "two_pm",
        "3 pm" => "three_pm",
        "4 pm" => "four_pm",
        "5 pm" => "five_pm",
        "6 pm" => "six_pm",
        "7 pm" => "seven_pm",
        "8 pm" => "eight_pm",
      }
      @playday = ""
      @playday = Playday.find_by date: @reservation.date
      if @playday.nil?
        return flash.now[:alert] = "Must choose a Valid Date, at least one Day from Today"
      end
      date = @reservation.date
      six = @reservation.six_hundred || 0
      eight = @reservation.eight_hundred || 0
      total_reservations = six + eight
      attribute = times[@reservation.time]
      if total_reservations == 0
        return flash.now[:alert] = "Must Choose at least One Passenger"
    end

      if attribute.nil?
          return flash.now[:alert] = "Must choose a Valid Time"
      end

      if (@playday.send(attribute) - total_reservations) < 0
        return flash.now[:alert] = "Too many Seats Selected. Only #{@playday.send(attribute)} spots available for #{@reservation.time}."
      end


      if @reservation.save
        flash[:notice] = "Reservation was saved."
        redirect_to [@reservation]
      else
        flash.now[:alert] = "There was an error saving the reservation. Please try again."
        render "playdays/show"
      end
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def delete
  end
end

private

def reservation_params
  params.require(:reservation).permit(:six_hundred, :eight_hundred, :date, :time, :photo, :discount, :playday_id )
end
