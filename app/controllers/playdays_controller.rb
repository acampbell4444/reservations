class PlaydaysController < ApplicationController
  def index
    @reservation = Reservation.new
    @calculator = Calculator.new
    now =  Time.at(Time.now.utc + Time.zone_offset('PST'))
    formatted_now = (now.strftime("%m-%d-%Y").to_s)
    now_plus_one_day= Time.at(Time.now.utc + Time.zone_offset('PST')) + 1.day
    plus_one_day_formatted = (now_plus_one_day.strftime("%m-%d-%Y").to_s)
    now_plus_3 = Time.at(Time.now.utc + Time.zone_offset('PST')) + 3.hours
    formatted_plus_3 = (now_plus_3.strftime("%m-%d-%Y").to_s)

    @playdays = Playday.all
    @playdays = Playday.where("date > ?", formatted_now)

    taco = Playday.find_by_date(plus_one_day_formatted)
    redirect_to taco



  end

  def redirect

  end

  def show
    @reservation = Reservation.new
    @playday = Playday.friendly.find(params[:id])#id
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_url, :notice => "Must Choose a Date Later than Today's Date.")

  end

  def new
    @playday = Playday.new
  end

  def edit
  end

  def update
  end

  def create
    id = params[:playday][:date]
    if !(id == "")
      redirect_to playday_path(id)
    else
      redirect_to(root_url, :notice => "Must Enter a Valid Date.")
    end
  end

  def destroy
  end

  def availability?
    params[:commit] == "Check Availability!"
  end
end
