$(document).ready(function() {
  $('#image-upload').on('click', function() {
    $('#post_picture').click();
    $('#post_picture').on('change', function() {
      var path = $('#post_picture').val().slice($('#post_picture').val().lastIndexOf("\\") + 1, $('#post_picture').val().length)
      if(path.length > 12) {
        path = path.slice(0, 11) + "..."
      }
      $('#placeholder').text(path)
      $('#check').removeClass('hidden')
    })
  })
  $('form input').on('click', function() {
    $(this).disabled = true
  })
})