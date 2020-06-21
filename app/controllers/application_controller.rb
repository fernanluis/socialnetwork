class ApplicationController < ActionController::Base
  # Now the default value is to raise an exception if the token is not matched.
  # The API calls will not have the token. If the application is expecting api calls
  # then the strategy should be changed from :exception to :null_session.
  protect_from_forgery with: :exception

  layout :set_layout

  protected
  def set_layout
      "application"
  end

end
