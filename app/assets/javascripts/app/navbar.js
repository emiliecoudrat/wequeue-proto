$(document).ready(function() {
  $(document).click(function(event) {
    var clickover = $(event.target);
    var _opened = $(".dropdown-menu").hasClass("dropdown-menu in");
    if (_opened === true && !clickover.hasClass("dropdown-toggle")) {
      $("button.dropdown-toggle").click();
    }
  });
});