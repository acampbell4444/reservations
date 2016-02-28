class CalculatorsController < ApplicationController

  def new
    @calculator = Calculator.new
  end

  def index
    @calculators = Calculator.all
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
     flash[:notice] = "Your estimate was calculated."
     redirect_to calculator_path(@calculator)

    else
      flash.now[:alert] = "There was an error saving the calculator. Please try again."
      render :new
    end
  end

  def edit

  end

  def update
  end

  def show
    @calculator = Calculator.find(params[:id])
  end

  def delete
  end



    private

  def calculator_params
    params.require(:calculator).permit(:six_hundred, :eight_hundred, :discount_code, :photo_package)
  end

end
