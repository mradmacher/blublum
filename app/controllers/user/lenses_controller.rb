class User::LensesController < ApplicationController
  def index
    render json: Lens.all.includes(:pricing)
  end
end
