class ChargesController < ApplicationController
  def new
    if current_user
      @subscription = Subscription.DEFAULT / 100
      @stripe_btn_data = {
        key: "#{Rails.configuration.stripe[:publishable_key]}",
        description: "Premium User Upgrade",
        amount: Subscription.DEFAULT, 
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
      amount: Subscription.DEFAULT,
      description: "Premium User Upgrade",
      currency: 'usd'
    )
   
    flash[:notice] = "Thanks for upgrading, #{current_user.email}! You can now create private wikis."
    enable_premium
    redirect_to wikis_path 
   
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private
  
  def enable_premium
    current_user.update_attributes(premium: true) 
  end
end

