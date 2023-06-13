class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
# POST /api/v1/sign_in
def create
  resource = User.find_for_database_authentication(email: params[:user][:email])
  return invalid_login_attempt unless resource

  if resource.valid_password?(params[:user][:password])
    sign_in(resource_name, resource)
    resource.authentication_token = request.env['warden-jwt_auth.token']
    resource.save
    render json: { user: resource }, status: :created and return
  end

  invalid_login_attempt
end
  # DELETE /api/v1/sign_out
  def destroy
    token = request.headers['Authorization'].to_s.gsub('Bearer ', '')
    user = User.find_by(authentication_token: token)

    if user
      user.clear_jwt_token
      user.authentication_token = nil
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
    end
  end

  protected

  def jwt_revoked?(payload, token)
    RevokedToken.exists?(token: token)
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end
end
