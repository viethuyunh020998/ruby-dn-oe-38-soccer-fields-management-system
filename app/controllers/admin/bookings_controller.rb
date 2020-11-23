class Admin::BookingsController < AdminController
  before_action :load_booking, only: :update

  def index
    @bookings = Booking.status_asc.paginate page: params[:page],
      per_page: Settings.admin_booking.per_page
  end

  def update
    respond_to do |format|
      if @booking.update_status params[:stt]
        format.json{render json: @booking, status: :created}
      else
        format.json{render status: :unprocessable_entity}
      end
    end
  end

  private

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:warning] = t "message.update_booking.not_exist_id"
    redirect_to admin_bookings_path
  end
end
