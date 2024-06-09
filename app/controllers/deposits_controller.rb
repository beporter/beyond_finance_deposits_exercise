class DepositsController < ApplicationController
  def show
    render json: Deposit.find(params[:id])
  end
end
