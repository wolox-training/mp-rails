class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_default_locale

  def configure_permitted_parameters
    params = %i[first_name last_name email password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: params)
  end

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_record_not_found
    render(json: { error: 'Nothing found' }, status: :not_found)
  end

  private

  def set_default_locale
    I18n.locale = api_v1_user_signed_in? ? current_api_v1_user.locale.to_sym : I18n.default_locale
  end
end
