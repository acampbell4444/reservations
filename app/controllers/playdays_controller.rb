class PlaydaysController < ApplicationController
  def index
    @playdays = Playday.all
      if params[:search]
        @playdays = Playday.search(params[:search])
     else
       @playdays = Playday.where("date > ?", Date.today.strftime("%m-%d-%Y").to_s)
     end
  end

  def show
    @playday = Playday.friendly.find(params[:id])#id
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
    redirect_to playday_path(id)
  end

  def destroy
  end

  def availability?
    params[:commit] == "Check Availability!"
  end
end
