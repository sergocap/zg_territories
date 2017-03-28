class RobokassaController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  skip_before_filter :verify_authenticity_token
  before_filter :create_notification
  before_filter :find_payment

  def paid
    if @notification.acknowledge
      @payment.approve!
      render :text => @notification.success_response
    else
      head :bad_request
    end
  end

  def success
    if !@payment.approved? && @notification.acknowledge
      @payment.approve!
    end

    redirect_to root_path
  end

  def fail
    redirect_to root_path
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, :secret => Settings['robokassa.secret_2'])
  end

  def find_payment
    @payment = Payment.find(@notification.item_id)
  end
end
