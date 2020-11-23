$(document).on('click','.handle-request-booking',function(){
  $.ajax({
    type: 'PATCH',
    url: "/admin/bookings/"+$(this).data().id,
    data: {
      id: $(this).data().id,
      stt: $(this).data().stt
    },
    dataType: 'JSON'
  }).done(function (data) {
    Swal.fire(
      'Xác nhận thành công',
      '',
      'success'
    ).then((result) => {
      if (result.isConfirmed) {
        location.reload();
      }
    })
  }).fail(function (data) {
    Swal.fire(
      'Xác nhận thất bại',
      '',
      'error'
    ).then((result) => {
      if (result.isConfirmed) {
        location.reload();
      }
    })
  });
});
