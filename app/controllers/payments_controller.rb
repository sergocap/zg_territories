class PaymentsController < ApplicationController
  def create
    payment = Payment.new(payment_params)
    payment.user_id = current_user.id
    if payment.save
      redirect_to payment.service_url and return
    else
      redirect_to payment.organization and return
    end
  end

  def payment_params
    params.permit([:duration, :paymentable_type, :organization_id, :paymentable_id, :amount, :details])
  end
end
