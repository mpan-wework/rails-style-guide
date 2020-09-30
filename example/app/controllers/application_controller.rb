class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |e|
    render json: { message: e.message }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  rescue_from ArgumentError do |e|
    render json: { message: e.message }, status: :unprocessable_entity
  end
end
