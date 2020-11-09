$(document).ready(function() {
  $('.handle-request-booking').click(function() {
    $.ajax({
      type: 'PATCH',
      url: "/admin/bookings/"+$(this).data().id,
      data: {
        id: $(this).data().id,
        stt: $(this).data().stt
      },
      dataType: 'JSON'
    }).done(function (data) {
      alert(data.notice);
    }).fail(function (data) {
      alert(data.alert);
    });
    location.reload();
  });
})
