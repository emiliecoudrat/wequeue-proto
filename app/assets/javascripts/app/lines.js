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
    $('#map').on('click', function() {
      $.each($('.infowindow'), function(index, item) {
        $(this).show()
      })
      setTimeout(function() {
        $.each($('.infowindow'), function(index, item) {
          $(this).parent().parent().parent().prev().remove()
          $(this).parent().parent().parent().next().remove()
        })
        $('.infowindow span').on('click', function(event) {
          setTimeout(function() {
            $('.infowindow span').parent().parent().hide();
          }, 50)
        })
      }, 50)
    })
  }
})