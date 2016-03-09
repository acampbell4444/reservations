class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.admin?
      @reservations = Reservation.all
    elsif current_user.standard?
      @reservations = Reservation.all.where(user: current_user)
    end
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
        "830 am" => "eight_thirty_am",
        "9 am" => "nine_am",
        "930 am" => "nine_thirty_am",
        "10 am" => "ten_am",
        "1030 am" => "ten_thirty_am",
        "11 am" => "eleven_am",
        "1130 am" => "eleven_thirty_am",
        "12 pm" => "twelve_pm",
        "1230 pm" => "twelve_thirty_pm",
        "1 pm" => "one_pm",
        "130 pm" => "one_thirty_pm",
        "2 pm" => "two_pm",
        "230 pm" => "two_thirty_pm",
        "3 pm" => "three_pm",
        "330 pm" => "three_thirty_pm",
        "4 pm" => "four_pm",
        "430 pm" => "four_thirty_pm",
        "5 pm" => "five_pm",
        "530 pm" => "five_thirty_pm",
        "6 pm" => "six_pm",
        "630 pm" => "six_thirty_pm",
        "7 pm" => "seven_pm",
        "730 pm" => "seven_thirty_pm",
        "8 pm" => "eight_pm",
      }
      @playday = Playday.find_by date: @reservation.date
      now_plus_4 = Time.at(Time.now.utc + Time.zone_offset('PST')) + 4.hours
      formatted_plus_4 = (now_plus_4.strftime("%m-%d-%Y").to_s)
      formatted_plus_4
      if formatted_plus_4 >= @reservation.date && current_user.standard?
        flash[:alert] = "Reservation was not Saved! Online reservations must be made by no later than 8pm on the day before the activity. No online reservation dates
        can be later than #{Playday.last.date}. To reserve by phone call 310-510-1777."
        return redirect_to :back
      end
      @reservation.date = @playday.date
      six = @reservation.six_hundred || 0
      eight = @reservation.eight_hundred || 0
      total_reservations = six + eight
      attribute = times[@reservation.time]
      if total_reservations == 0
        flash[:alert] = "Reservation was not Saved! Must Choose at least One Passenger."
        return redirect_to :back
    end
    if attribute.nil?
      flash[:alert] = "Reservation was not Saved! Must choose a Departure Time"
      return redirect_to request.referrer
    end
      if (@playday.send(attribute) - total_reservations) < 0
        flash[:alert] = "Reservation was not Saved! Too many Seats Selected. Only #{@playday.send(attribute)} spots available for #{@reservation.time}."
        return redirect_to :back
      end

        if @reservation.valid?
          begin
            Stripe::Customer.create(
             email: @reservation.customer_email || current_user.email,
             description: "customer name: #{@reservation.customer_last_name},
             #{@reservation.customer_first_name}, phone: #{@reservation.customer_phone_number},
             res. created by user##{@reservation.user.id}, reservation date: #{@playday.date}",
             card: params[:stripeToken]
           )

           rescue Stripe::CardError => e
             charge_error = e.message
           end

           if charge_error
             flash[:error] = charge_error
             redirect_to :back
           else @reservation.save
             flash[:notice] = "Reservation was saved."
             redirect_to [@reservation]
           end
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
    old_reservation_time = @reservation.time
    #raise "#{old_reservation_time}"
    six = @reservation.six_hundred || 0
    eight = @reservation.eight_hundred || 0
    old_total_reservations = six + eight

    @reservation.assign_attributes(reservation_params)
    times = {
      "8 am" => "eight_am",
      "830 am" => "eight_thirty_am",
      "9 am" => "nine_am",
      "930 am" => "nine_thirty_am",
      "10 am" => "ten_am",
      "1030 am" => "ten_thirty_am",
      "11 am" => "eleven_am",
      "1130 am" => "eleven_thirty_am",
      "12 pm" => "twelve_pm",
      "1230 pm" => "twelve_thirty_pm",
      "1 pm" => "one_pm",
      "130 pm" => "one_thirty_pm",
      "2 pm" => "two_pm",
      "230 pm" => "two_thirty_pm",
      "3 pm" => "three_pm",
      "330 pm" => "three_thirty_pm",
      "4 pm" => "four_pm",
      "430 pm" => "four_thirty_pm",
      "5 pm" => "five_pm",
      "530 pm" => "five_thirty_pm",
      "6 pm" => "six_pm",
      "630 pm" => "six_thirty_pm",
      "7 pm" => "seven_pm",
      "730 pm" => "seven_thirty_pm",
      "8 pm" => "eight_pm",
    }

    @playday = Playday.find_by date: @reservation.date  #new playday
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
    attribute_two = times[old_reservation_time]


    if total_reservations == 0
      flash[:alert] = "Must Choose at least One Passenger, or cancel reservation."
      return render :edit
    end
    if attribute.nil?
      flash[:alert] = "Must choose a Departure Time"
      return render :edit
    end

#if date and time of the reservation are same
if (old_playday.date == @reservation.date) && old_reservation_time == @reservation.time
  if ((@playday.send(attribute) - total_reservations)) + old_total_reservations < 0
    flash[:alert] = "Too many Seats Selected. Only #{@playday.send(attribute) + old_total_reservations} spots available for #{@reservation.time}."
    return render :edit
  end
  new_num =  "#{(@playday.send(attribute) - total_reservations + old_total_reservations)}"
  @playday.update_attribute(attribute.to_sym, new_num.to_i)
else
    if (@playday.send(attribute) - total_reservations) < 0
      flash[:alert] = "Too many Seats Selected. Only #{@playday.send(attribute)} spots available for #{@reservation.time}."
      return render :edit
    end

    new_num =  "#{(@playday.send(attribute) - total_reservations)}"

    @playday.update_attribute(attribute.to_sym, new_num.to_i)

    new_count =  "#{(old_playday.send(attribute_two) + old_total_reservations)}"
    old_playday.update_attribute(attribute_two.to_sym, new_count.to_i)
  end

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
      "830 am" => "eight_thirty_am",
      "9 am" => "nine_am",
      "930 am" => "nine_thirty_am",
      "10 am" => "ten_am",
      "1030 am" => "ten_thirty_am",
      "11 am" => "eleven_am",
      "1130 am" => "eleven_thirty_am",
      "12 pm" => "twelve_pm",
      "1230 pm" => "twelve_thirty_pm",
      "1 pm" => "one_pm",
      "130 pm" => "one_thirty_pm",
      "2 pm" => "two_pm",
      "230 pm" => "two_thirty_pm",
      "3 pm" => "three_pm",
      "330 pm" => "three_thirty_pm",
      "4 pm" => "four_pm",
      "430 pm" => "four_thirty_pm",
      "5 pm" => "five_pm",
      "530 pm" => "five_thirty_pm",
      "6 pm" => "six_pm",
      "630 pm" => "six_thirty_pm",
      "7 pm" => "seven_pm",
      "730 pm" => "seven_thirty_pm",
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
  params.require(:reservation).permit(:six_hundred, :eight_hundred, :date, :time, :photo, :discount, :playday_id, :comments, :customer_email, :customer_first_name, :customer_last_name, :customer_phone_number )
end

end
