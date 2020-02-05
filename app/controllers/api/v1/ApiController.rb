class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :internal_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :validation_error

  private

  def internal_error
    render json: {message: 'Estamos trabalhando para resolver!'}, status: 500
  end

  def not_found
    render json: {message: 'Nao encontramos registros!'}, status: 404
  end

  def validation_error
    render json: { message: @job.errors }, status: 412
  end
end