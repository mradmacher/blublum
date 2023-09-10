class User::OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    if order.save
      render json: order
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :client_id,
      :frame_id,
      :lens_id,
    )
  end
end
