class PlaydaysController < ApplicationController
  def index
    @playdays = Playday.all
  end

  def show
    @playday = Playday.find(params[:id])
  end

  def new
    @playday = Playday.new
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end
end
