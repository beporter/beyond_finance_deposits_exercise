class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found


  private

  def not_found
    render json: {error: { msg: 'not found', code: Rack::Utils.status_code(:not_found) } }, status: :not_found
  end
end
