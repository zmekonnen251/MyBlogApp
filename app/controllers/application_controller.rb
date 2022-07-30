class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  add_flash_types :info, :error, :success, :notice
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation bio photo])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation bio photo])
  end

  def after_sign_out_path_for(_scope)
    root_path
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = ApiHelper::JsonWebToken.decode(header)
      @current_user = User.find_by_email(@decoded[:user_email])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
