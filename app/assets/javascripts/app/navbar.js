$(document).ready(function() {
  $(document).on('click', function() {
    if($('.in').length > 0 && !$(this).parent().parent().hasClass('dropdown')) {
      $('#menu').click();
    }
  });
});