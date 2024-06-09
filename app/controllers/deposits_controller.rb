class DepositsController < ApplicationController
  # GET /tradelines/:tradeline_id/deposits
  def index
    render json: Deposit.where(tradeline: params[:tradeline_id])
  end

  # GET /deposits/:id
  def show
    render json: Deposit.find(params[:id])
  end

  # POST /tradelines/:tradeline_id/deposits { deposit: { amount_cents: 0, deposit_date: '2024-06-08' } }
  def create()
    tradeline = Tradeline.find(params[:tradeline_id]) # Might raise ActiveRecord::RecordNotFound.

    deposit = Deposit.create!({tradeline:}.merge(deposit_params)) # Might raise ActiveRecord::RecordInvalid

    render json: deposit, head: :created, location: deposit_url(deposit)
  end

  private

  def deposit_params
    params.require(:deposit).permit(:amount_cents, :deposit_date)
  end
end
