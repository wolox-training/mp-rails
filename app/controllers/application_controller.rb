class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  alias current_user current_api_v1_user

  def configure_permitted_parameters
    params = %i[first_name last_name email password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: params)
  end

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  rescue_from Pundit::NotAuthorizedError, with: :handle_unauthorized_record

  def handle_record_not_found
    render(json: { error: 'Nothing found' }, status: :not_found)
  end

  def handle_unauthorized_record
    render(json: { error: 'Unauthorized' }, status: :unauthorized)
  end

  private

  def set_locale
    I18n.locale = api_v1_user_signed_in? ? current_api_v1_user.locale.to_sym : I18n.default_locale
  end
end
