class Api::V1::PasswordsController < Devise::PasswordsController
  respond_to :json
  # PUT  /api/v1/password
  api :PUT, '/v1/users/password', 'Update user password'
  param :user, Hash, desc: 'User info', required: true do
    param :email, String, desc: 'User email', required: true
    param :password, String, desc: 'User password', required: true
    param :password_confirmation, String, desc: 'User password confirmation', required: true
  end
  error code: 404, desc: 'Password not updated!'
  def update
    self.resource = resource_class.find_by(email: resource_params[:email])

    if resource && resource.update(resource_params)
      bypass_sign_in(resource) # Manually sign in the user
      render json: { message: 'Your password has been successfully reset' }, status: :ok
    else
      render json: { error: 'Invalid user or password confirmation' }, status: :unprocessable_entity
    end
  end

  private

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
