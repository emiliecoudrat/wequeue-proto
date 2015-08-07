$(document).ready(function() {
  if($('.alert').length > 0 ) {
    var height = $('.alert').height()
    setTimeout(function(){
      $('.alert').css('margin-top', -height - 30)
    }, 5000)
  }
})
