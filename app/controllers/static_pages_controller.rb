class StaticPagesController < ApplicationController
  def home
    @locations = Location.order_by_name
                         .paginate(page: params[:page],
                            per_page: Settings.paginate.home)
  end

  def order; end

  def detail; end
end
