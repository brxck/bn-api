class ApiController < ApplicationController

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def render_unauthorized(message)
    errors = { errors: [{ detail: message }] }
    render json: errors, status: :unauthorized
  end

  def authenticate_token
    token = cookies.signed[:token]
    if user = User.find_by(token: token)
      # Mitigate timing attacks
      ActiveSupport::SecurityUtils.secure_compare(token, user.token)
      user
    end
  end
end
