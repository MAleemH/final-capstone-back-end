class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request
  load_and_authorize_resource
  api :GET, '/v1/users', 'Get all users'
  error code: 404, desc: 'Users not found!'
  def index
    if current_user.role == 'admin'
      @users = User.all
    else
      @users = [current_user]
    end

    if @users.empty?
      render json: { error: 'No users found.' }, status: :unprocessable_entity
    else
      render json: @users
    end
  end

  api :GET, '/v1/users/:id', 'Get user with id'
  param :id, :number, desc: 'id of the requested user', required: true
  error code: 404, desc: 'User not found!'
  def show
    @user =User.find_by(id: params[:id])
    if @user.present? && (current_user.role == 'admin' || @user.id == current_user.id)
      render json: @user
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  api :DELETE, '/v1/users/:id', 'Delete user by id'
  param :id, :number, desc: 'id of the requested user', required: true
  error code: 404, desc: 'User not found!'
  def destroy
    authorize! :destroy, User
    @user = User.find_by(id: params[:id])
    if @user.destroy
      render json: { message: 'User deleted successfully!' }, status: :ok
    else
      render json: { error: 'Failed to delete the User.' }, status: :unprocessable_entity
    end
  end
end
