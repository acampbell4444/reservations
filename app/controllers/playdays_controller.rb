class PlaydaysController < ApplicationController
  def index
    @calculator = Calculator.new
    @playdays = Playday.all
      if params[:search]
        @playdays = Playday.search(params[:search])
     else
       @playdays = Playday.where("date > ?", Date.today.strftime("%m-%d-%Y").to_s)
     end
  end

  def show
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
