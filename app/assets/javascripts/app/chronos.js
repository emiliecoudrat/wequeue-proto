function chrono(h, m, s) {
  $('#hours').text(h)
  $('#minutes').text(m)
  $('#seconds').text(s)

  setInterval(function() {
    if(s < 59) {
      s++
    } else if(s == 59) {
      if(m < 59) {
        m++
        s = 0
      } else if(m == 59) {
        h++
        m = 0
        s = 0
      }
    }
    $('#hours').text(h)
    $('#minutes').text(m)
    $('#seconds').text(s)
    if(s <= 30) {
      var orientation = Math.floor(90 + 6 * s )
      var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FFFFFF 50%), linear-gradient(90deg, #FFFFFF 50%, transparent 50%)';
    } else {
      var orientation = Math.floor(90 + 6 * (s - 30))
      var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FF5556 50%), linear-gradient(90deg, #FFFFFF 50%, transparent 50%)';
    }
    var timer = document.getElementById('timer-frame');
    timer.style.backgroundImage = value;
  }, 1000);
}

function getCssValuePrefix() {
  var rtrnVal = '';//default to standard syntax
  var prefixes = ['-o-', '-ms-', '-moz-', '-webkit-'];

  // Create a temporary DOM object for testing
  var dom = document.createElement('div');

  for (var i = 0; i < prefixes.length; i++)
  {
      // Attempt to set the style
      dom.style.background = prefixes[i] + 'linear-gradient(#000000, #ffffff)';

      // Detect if the style was successfully set
      if (dom.style.background)
      {
          rtrnVal = prefixes[i];
      }
  }

  dom = null;
  delete dom;

  return rtrnVal;
}