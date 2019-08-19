class PusherController < ApplicationController

    def location
        p 'hit this endpoint?'
        p params
        username = pusher_params[:username]
        p username
        location = pusher_params[:location]
        p location
        response = Pusher.trigger('presence-channel', 'location-update', {'username' => username, 'location' => location})
        render json: response, status: 200
    end

    def authenticate
        channel    = pusher_params[:channel_name]
        socket_id  = pusher_params[:socket_id]
        presence_data = {:user_id => @current_user[:id], :user_info => {:username => @current_user[:username]}}
        
        p channel
        p socket_id
        p presence_data
        valid = true
        if valid
            response = Pusher.authenticate(channel, socket_id, presence_data)
            p response
            render json: response
        else
            render json: 'Not authorized', status: '403'
        end
    end

    private
    def pusher_params
        params.permit(:username, :channel_name, :socket_id, location: [:lat, :lng, :altitude])
    end
end