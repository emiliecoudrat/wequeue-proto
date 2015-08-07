$('.close-white').on('click', function() {
  $(this).parent().remove();
})

$('#action-timer').on('click', function() {
  $(this).parent().submit();
})