class ReservationsController < ApplicationController
  #before_action :authenticate_user!
  respond_to :json, :html

  def index
    @reservations = Reservation.all # need to scope this
  end

  def price
    @playday = Playday.find(params[:playday_id])
    @reservation = Reservation.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @reservation, methods: [:total_price]}
    end
  end

  def new
    @playday = Playday.find(params[:playday_id])
    @reservation = Reservation.new
  end

  def create
    @playday = Playday.find(params[:playday_id])
    @reservation = @playday.reservations.build(reservation_params)
    #@reservation.user = current_user

    if @reservation.save
     flash[:notice] = "Reservation was saved."
     redirect_to [@playday, @reservation]

    else
      flash.now[:alert] = "There was an error saving the reservation. Please try again."
      render :new
    end
  end

  def edit
    @playday = Playday.find(params[:playday_id])
    @reservation = Reservation.find(params[:id])
  end

  def update
  end

  def show
    @reservation = Reservation.find(params[:id])
    #if @reservation.email.nil?
    #  redirect_to edit_playday_reservation_path(@reservation.playday, @reservation)
    #end

  end

  def delete
  end
end

private

def reservation_params
  params.require(:reservation).permit(:six_hundred, :eight_hundred, :date, :time)
end
