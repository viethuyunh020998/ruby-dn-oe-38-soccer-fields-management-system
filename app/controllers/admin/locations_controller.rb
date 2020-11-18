class Admin::LocationsController < ApplicationController
  def index
    @locations = Location.order_by_name
                         .paginate(page: params[:page],
                            per_page: Settings.paginate.manage)
  end
end
