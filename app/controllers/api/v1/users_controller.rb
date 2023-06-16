class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request
  load_and_authorize_resource
  api :GET, '/v1/users', 'Get all users'
  error code: 404, desc: 'Users not found!'
  def index
    @users = User.all
    if @users.empty?
      render json: { error: 'Users not found!' }, status: 404
    else
      render json: @users
    end
  end

  api :GET, '/v1/users/:id', 'Get user with id'
  param :id, :number, desc: 'id of the requested user', required: true
  error code: 404, desc: 'User not found!'
  def show
    @user = User.find_by(id: params[:id])
    if @user.present?
      render json: @user
    else
      render json: { error: 'User not found!' }, status: 404
    end
  end

  api :DELETE, '/v1/users/:id', 'Delete user by id'
  param :id, :number, desc: 'id of the requested user', required: true
  error code: 404, desc: 'User not found!'
  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      render json: { message: 'User successfully deleted!' }, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
