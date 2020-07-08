class ApplicationController < ActionController::Base
  # Ahora el valor predeterminado es generar una excepción si el token no coincide.
  # Las llamadas a la API no tendrán el token. Si la aplicación espera llamadas de API,
  # la estrategia debe cambiarse de: excepción a: null_session.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :set_layout

  protected
  def set_layout
      "application"
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name last_name username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name last_name username])
  end

end
