class Admin::BookingsController < AdminController
  def index
    @bookings = Booking.status_asc.paginate page: params[:page],
      per_page: Settings.admin_booking.per_page
  end
end
