$('.close-white').on('click', function() {
  $(this).parent().remove();
})

$('#action-timer').on('click', function() {
  $(this).parent().submit();
})

$(document).ready(function() {
  if($('#map').length > 0) {
    var mapHeight = $(window).height() - $('nav').height() - 20 - $('.search').height() - $('footer').height();
    $('#map').height(mapHeight);

  }
})