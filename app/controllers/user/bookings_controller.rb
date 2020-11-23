class User::BookingsController < UserController
  before_action :logged_in_user, only: %i(seach_yard_for_booking index)

  def seach_yard_for_booking
    yard_arr = Yard.all_yard_by_type(params[:location_id],
                                     params[:type_yard]).pluck(:id)
    @yards = TimeCost.time_yard yard_arr, params[:hours]
    @booked = Booking.find_date_booking(@yards.pluck(:id),
                                        params[:date]).pluck(:time_cost_id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    booking_param = Hash.new
    booking_param[:time_cost_id] = params[:id_timecost]
    booking_param[:booking_date] = params[:date]
    @booking = current_user.bookings.build booking_param
    @data = Hash.new
    respond_to do |format|
      handle_message @booking.save, @data
      format.json{render json: @data.to_json, status: :created}
    end
  end

  def index
    @bookings = current_user.bookings.date_desc.paginate page: params[:page],
      per_page: Settings.admin_booking.per_page
  end
  private

  def logged_in_user
    return if logged_in?

    strore_location_system static_page_path(params[:location_id])
    respond_to do |format|
      format.js do
        render js:
        "Swal.fire('#{t('message.booking.pls_login')}')
        .then((value) => {
          window.location='#{login_path}'
        })"
      end
    end
  end

  def handle_message condition, data
    if condition
      data[:success] = true
      data[:title] = t "message.booking.booking_succ"
      data[:content] = t "message.booking.booking_succ_mess"
    else
      data[:title] = t "message.booking.booking_fail"
      data[:content] = t "message.booking.booking_fail_mess"
    end
  end
end
