class FloorplansController < ApplicationController

    def index
        floorplans = Floorplan.all
        render json: floorplans
    end
end
