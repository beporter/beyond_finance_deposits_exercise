class TradelinesController < ApplicationController
  def index
    render json: Tradeline.includes(:deposits).all, methods: :balance_cents, include: :deposits
  end

  def show
    render json: Tradeline.includes(:deposits).find(params[:id]), methods: :balance_cents, include: :deposits
  end
end
