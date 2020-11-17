class User::BookingsController < UserController
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
end
