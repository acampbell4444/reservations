class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    #if current_user.standard?
    #  charge = Stripe::Charge.create(
    #    customer: customer.id,
    #    amount: 0,
    #    description: "California Parasail",
    #    currency: 'usd'
    #  )
    #  flash[:notice] = "Thanks for upgrading"
    #  redirect_to reservations_path
    #end
    redirect_to :back
  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
  end

  def new
      @stripe_btn_data = {
        key: Rails.configuration.stripe[:publishable_key].to_s,
        description: "California Parasail",
        amount: 0
      }
  end
end
