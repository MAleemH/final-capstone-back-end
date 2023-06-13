class Api::V1::PasswordsController < Devise::PasswordsController
  respond_to :json
   # PUT  /api/v1/password
  def update
    self.resource = resource_class.find_by(email: resource_params[:email])

    if resource && resource.update(resource_params)
      sign_in(resource, bypass: true) # Manually sign in the user
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
