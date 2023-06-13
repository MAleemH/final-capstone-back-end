class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json


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
