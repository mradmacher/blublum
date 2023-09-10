class Admin::LensesController < ApplicationController
  def index
    render json: Lens.all
  end

  def create
    lens = Lens.new(lens_params)
    if lens.save
      render json: lens
    else
      render json: { errors: lens.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def lens_params
    params.require(:lens).permit(
      :name,
      :prescription_type,
      :lens_type,
      :stock,
      :description,
      pricing_attributes: [
        :usd,
        :gbp,
        :eur,
        :jod,
        :jpy,
      ]
    )
  end
end
