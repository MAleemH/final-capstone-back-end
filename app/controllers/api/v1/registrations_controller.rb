class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  api :POST, '/v1/users', 'Create a new user'
  param :user, Hash, desc: 'User info', required: true do
    param :email, String, desc: 'User email', required: true
    param :password, String, desc: 'User password', required: true
    param :password_confirmation, String, desc: 'User password confirmation', required: true
    param :role, String, desc: 'User role', default_value: 'client'
    param :name, String, desc: 'User name', default_value: 'name'
  end
  error code: 404, desc: 'User not created!'
  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      sign_in(resource)
      token = current_token
      resource.update(authentication_token: token) # Update the authentication_token field with the token
      render json: {
        user: resource
      }, status: :created
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { error: resource.errors.full_messages.first }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :name)
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
