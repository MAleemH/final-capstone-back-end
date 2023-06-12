class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all
        if @users.empty?
            render json:{ error: "Users not found!" }, status: 404
        else
            render json: @users
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user.present?
            render json: @user
        else
            render json: { error: "User not found!" }, status: 404
        end
    end

    def destroy
        @user  = User.find_by(id: params[:id])
        if @user.destroy
            render json: { message: "User successfully deleted!" }, status: :ok
        else
            render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end
end
