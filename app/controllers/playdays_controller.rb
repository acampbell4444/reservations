class PlaydaysController < ApplicationController
  def index
    @reservation = Reservation.new
    #@calculator = Calculator.new
    now =  Time.at(Time.now.utc + Time.zone_offset('PST'))
    formatted_now = (now.strftime("%m-%d-%Y").to_s)
    now_plus_one_day= Time.at(Time.now.utc + Time.zone_offset('PST')) + 1.day
    plus_one_day_formatted = (now_plus_one_day.strftime("%m-%d-%Y").to_s)
    now_plus_3 = Time.at(Time.now.utc + Time.zone_offset('PST')) + 3.hours
    formatted_plus_3 = (now_plus_3.strftime("%m-%d-%Y").to_s)

    @playdays = Playday.all
    if current_user.nil? || current_user.standard?
     @playdays = Playday.where("date >= ?", formatted_now)
     end

    #raise "#{Playday.first.date}"
    if current_user.nil?
      show_day = Playday.find_by_date(formatted_now)
      redirect_to show_day
    else
      show_day = Playday.find_by_date(  plus_one_day_formatted )
      redirect_to show_day
    end
  end

  def redirect

  end

  def show
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: "California Parasail Reservation",
      amount: 0
    }
    @reservation = Reservation.new
    @playday = Playday.friendly.find(params[:id])#id
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_url, :notice => "Must Choose a Date Later than Today's Date.")

  end

  def new
    @playday = Playday.new
  end

  def edit
     @playday = Playday.find(params[:id])
  end

  def update
    @playday = Playday.find(params[:id])
    @playday.assign_attributes(playday_params)
    if @playday.save
      flash[:notice] = "Playday was saved."
      redirect_to [@playday]
    else
      flash.now[:alert] = "There was an error saving the playday. Please try again."
      render :edit
    end
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

  private

  def playday_params
    params.require(:playday).permit(
      :eight_am, :nine_am, :ten_am, :eleven_am, :twelve_pm,
      :one_pm, :two_pm, :three_pm, :four_pm, :five_pm, :six_pm, :seven_pm,
      :eight_thirty_am, :nine_thirty_am, :ten_thirty_am, :eleven_thirty_am, 
      :twelve_thirty_pm, :one_thirty_pm, :two_thirty_pm, :three_thirty_pm, :four_thirty_pm,
      :five_thirty_pm, :six_thirty_pm, :seven_thirty_pm
      )
  end

end
