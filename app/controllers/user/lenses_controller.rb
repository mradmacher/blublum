class User::LensesController < ApplicationController
  def index
    render json: Lens.all
  end
end
