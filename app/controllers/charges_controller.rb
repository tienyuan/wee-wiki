class ChargesController < ApplicationController
  def new
    if current_user
      @stripe_btn_data = {
        key: "#{Rails.configuration.stripe[:publishable_key]}",
        description: "Premium User Upgrade",
        amount: 1000, 
        email: current_user.email
      }
    end
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
   
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1000, #Amount.default
      description: "Premium User Upgrade",
      currency: 'usd'
    )
   
    flash[:notice] = "Thanks for upgrading, #{current_user.email}! You can now create private wikis."
    enable_premium(current_user)
    redirect_to wikis_path 
   
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

  def enable_premium(current_user)
    paid_user = User.find(current_user.id)
    paid_user.update_attributes(premium: true) 
  end
end

