class Admin::FramesController < ApplicationController
  def index
    render json: Frame.all
  end

  def create
    frame = Frame.new(frame_params)
    if frame.save
      render json: frame
    else
      render json: frame.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def frame_params
    params.require(:frame).permit(:name, :status, :stock, :description)
  end
end
