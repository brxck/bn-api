class SessionsController < ApiController
  before_action :require_login
  skip_before_action :require_login, only: [:create], raise: false

  def create
    if user = User.valid_login(params[:email], params[:password])
      user.regenerate_token
      cookies.signed[:token] = {value: user.token, httponly: true}
      render json: { id: user.id, email: user.email }
    else
      render_unauthorized('Error with your login or password')
    end
  end

  def destroy
    logout
    head :ok
  end

  def validate
    render json: { id: current_user.id, email: current_user.email }
  end

  private

  def logout
    current_user.invalidate_token
    cookies.delete(:token)
  end
end
