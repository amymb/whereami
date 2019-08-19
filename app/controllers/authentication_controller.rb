class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request
    
    def authenticate
        command = AuthenticateUser.call(params[:username], params[:password])

        if command.success?
            render json: command.result, :except => [:password_digest]
        else
            render json: { error: command.errors }, status: unauthorized
        end
    end
end

