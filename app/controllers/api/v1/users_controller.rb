class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all
        if @users.empty?
            render json:{ error: "Users not found!" }, status: 404
        else
            render json: @users
        end
    end
end
