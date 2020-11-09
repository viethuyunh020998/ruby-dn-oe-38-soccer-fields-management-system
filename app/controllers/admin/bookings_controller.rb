class Admin::BookingsController < AdminController
  before_action :load_booking, only: :update

  def index
    @bookings = Booking.status_asc.paginate page: params[:page],
      per_page: Settings.admin_booking.per_page
  end

  def update
    if @booking.update_status params[:stt]
      flash[:notice] = t "message.update_booking.update_sucess"
    else
      flash[:alert] = t "message.update_booking.update_fail"
    end
    respond_to do |format|
      format.html{render admin_bookings_path}
      format.json{render json: flash.to_hash}
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
