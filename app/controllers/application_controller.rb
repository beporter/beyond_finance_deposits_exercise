class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :validation_failed


  private

  def not_found
    render json: {
      error: {
        msg: 'not found',
        code: Rack::Utils.status_code(:not_found)
      }
    }, status: :not_found
  end

  def validation_failed(e)
    render json: {
      error: {
        msg: 'unprocessable entity',
        code: Rack::Utils.status_code(:unprocessable_entity),
        details: e.record.errors.messages
      }
    }, status: :unprocessable_entity
  end
end
