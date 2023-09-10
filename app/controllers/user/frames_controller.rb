class User::FramesController < ApplicationController
  def index
    render json: Frame.where(status: Frame::ACTIVE).includes(:pricing)
  end
end
