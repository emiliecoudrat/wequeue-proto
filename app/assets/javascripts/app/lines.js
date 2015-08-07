$('.close-white').on('click', function() {
  $(this).parent().remove();
})

$('#launch-timer').on('click', function() {
  $(this).parent().submit();
})