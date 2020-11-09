class Admin::LocationsController < ApplicationController
  def index
    @locations = Location.order_by_name
                         .paginate(page: params[:page],
                            per_page: Settings.paginate.manage)
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new location_params
    if @location.save
      flash[:success] = t "message.add_location"
      redirect_to admin_locations_path
    else
      flash.now[:warning] = t "message.fail"
      render :new
    end
  end

  private

  def location_params
    params.require(:location)
          .permit(:name, :phone, :address, :distric, :description)
  end
end
