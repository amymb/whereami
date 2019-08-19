class UsersController < ApplicationController
    before_action :authenticate_request, except: :create

    def index
        @users = User.all
        render json: @users
    end
    
    def show
        @user = User.find(params[:id])
        render json: @user
    end

    def current
        render json: @current_user, :except => [:password_digest, :created_at, :updated_at]
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, :except => [:password_digest, :updated_at], status: created
        else 
            render json: { errors: @user.errors.full_messages}, status: unprocessable_entity
        end
    end

    private
    def user_params
        params.require(:username)
    end



end
