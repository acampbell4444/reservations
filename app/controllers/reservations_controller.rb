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
      @playday = Playday.current_scope
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
      @playday = Playday.find_by date: @reservation.date
      now_plus_4 = Time.at(Time.now.utc + Time.zone_offset('PST')) + 4.hours
      formatted_plus_4 = (now_plus_4.strftime("%m-%d-%Y").to_s)
      formatted_plus_4
      if formatted_plus_4 >= @reservation.date #&& current_user.standard?
        flash[:alert] = "Online reservations must be made by no later than 8pm on the day before the activity. To reserve by phone call 310-510-1777."
        return redirect_to :back
      end
      @reservation.date = @playday.date
      six = @reservation.six_hundred || 0
      eight = @reservation.eight_hundred || 0
      total_reservations = six + eight
      attribute = times[@reservation.time]
      if total_reservations == 0
        flash[:alert] = "Must Choose at least One Passenger."
        return redirect_to :back
    end
    if attribute.nil?
      flash[:alert] = "Must choose a Departure Time"
      return redirect_to request.referrer
    end
      if (@playday.send(attribute) - total_reservations) < 0
        flash[:alert] = "Too many Seats Selected. Only #{@playday.send(attribute)} spots available for #{@reservation.time}."
        return redirect_to :back
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
    @playday = Playday.find_by_date(@reservation.date)
  end

  def update
    @reservation = Reservation.find(params[:id])
    old_playday = Playday.find_by_date(@reservation.date)
    six = @reservation.six_hundred || 0
    eight = @reservation.eight_hundred || 0
    old_total_reservations = six + eight
    @reservation.assign_attributes(reservation_params)

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

    @playday = Playday.find_by date: @reservation.date
    now = Time.at(Time.now.utc + Time.zone_offset('PST'))
    formatted_now = (now.strftime("%m-%d-%Y").to_s)
    if formatted_now >= @reservation.date #&& current_user.standard?
      flash[:alert] = "Online reservations cannot be updated on the same day as your selected Date. To update by phone call 310-510-1777."
      return render :edit
    end
    six = @reservation.six_hundred || 0
    eight = @reservation.eight_hundred || 0
    total_reservations = six + eight
    attribute = times[@reservation.time]


    if total_reservations == 0
      flash[:alert] = "Must Choose at least One Passenger, or cancel reservation."
      return render :edit
    end
    if attribute.nil?
      flash[:alert] = "Must choose a Departure Time"
      return render :edit
    end

    if (@playday.send(attribute) - total_reservations) < 0
      flash[:alert] = "Too many Seats Selected. Only #{@playday.send(attribute)} spots available for #{@reservation.time}."
      return render :edit
    end

    new_num =  "#{(@playday.send(attribute) - total_reservations)}"
    @playday.update_attribute(attribute.to_sym, new_num)

    new_count =  "#{(old_playday.send(attribute) + old_total_reservations)}"
    old_playday.update_attribute(attribute.to_sym, new_count)

    if @reservation.save
      flash[:notice] = "Reservation was saved."
      redirect_to [@reservation]
    else
      flash.now[:alert] = "There was an error saving the reservation. Please try again."
      render "playdays/show"
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @playday = Playday.find_by_date(@reservation.date)
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
    six = @reservation.six_hundred || 0
    eight = @reservation.eight_hundred || 0
    total_reservations = six + eight
    attribute = times[@reservation.time]


    if @reservation.delete
      new_num =  "#{(@playday.send(attribute) + total_reservations)}"
      @playday.update_attribute(attribute.to_sym, new_num)

      flash[:notice] = "#{@reservation.user.firstname} #{@reservation.user.lastname}'s reservation (Id # #{@reservation.id}) for #{@reservation.date}- was deleted successfully."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error deleting the reservation."
      redirect_to :back
    end
  end

private

def reservation_params
  params.require(:reservation).permit(:six_hundred, :eight_hundred, :date, :time, :photo, :discount, :playday_id, :comments )
end

end
