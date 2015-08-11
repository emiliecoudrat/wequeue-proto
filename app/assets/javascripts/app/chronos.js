function chrono(h, m, s) {
  $('#hours').text(h)
  if(String(m).length == 1) {
    $('#minutes').text('0' + String(m))
  } else {
    $('#minutes').text(m)
  }
  if(String(s).length == 1) {
    $('#seconds').text('0' + String(s))
  } else {
    $('#seconds').text(s)
  }

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
    if(String(m).length == 1) {
      $('#minutes').text('0' + String(m))
    } else {
      $('#minutes').text(m)
    }
    if(String(s).length == 1) {
      $('#seconds').text('0' + String(s))
    } else {
      $('#seconds').text(s)
    }
    if(m % 2 == 0) {
      if(s <= 30) {
        var orientation = Math.floor(90 + 6 * s )
        var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FFFFFF 50%), linear-gradient(90deg, #FFFFFF 50%, transparent 50%)';
      } else {
        var orientation = Math.floor(90 + 6 * (s - 30))
        var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FF5556 50%), linear-gradient(90deg, #FFFFFF 50%, transparent 50%)';
      }
    } else {
      if(s <= 30) {
        var orientation = Math.floor(90 + 6 * s )
        var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FF5556 50%), linear-gradient(270deg, #FFFFFF 50%, transparent 50%)';
      } else {
        var orientation = Math.floor(90 + 6 * (s - 30))
        var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FFFFFF 50%), linear-gradient(90deg, transparent 50%, #FFFFFF 50%)';
      }
    }
    var timer = document.getElementById('timer-frame');
    timer.style.backgroundImage = value;
  }, 1000);
}

function line(minutes) {
  $(document).ready(function() {
    var timer = document.getElementById('timer-frame');
    if(timer) {
      if(minutes > 60) {
        var value = 'none'
      } else if(minutes > 30) {
        var orientation = Math.floor(90 + 6 * (minutes - 30))
        var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FF5556 50%), linear-gradient(90deg, #FFFFFF 50%, transparent 50%)';
      } else {
        var orientation = Math.floor(90 + 6 * minutes)
        var value = 'linear-gradient(' + orientation + 'deg, transparent 50%, #FFFFFF 50%), linear-gradient(90deg, #FFFFFF 50%, transparent 50%)';
      }
      timer.style.backgroundImage = value;
    }
  })
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
    if (dom.style.background) {
        rtrnVal = prefixes[i];
    }
  }
  dom = null;
  delete dom;
  return rtrnVal;
}


// chrono = [id, hours, minutes, seconds]
function chronos(chronos) {
  var chronosArray = JSON.parse(chronos);
  var hours = []
  var minutes = []
  var seconds = []
  for(i = 0; i < chronosArray.length; i++) {
    hours[i] = parseInt(chronosArray[i][1])
    minutes[i] = parseInt(chronosArray[i][2])
    seconds[i] = parseInt(chronosArray[i][3])
    $('#chrono_' + chronosArray[i][0] + ' #hours').text(chronosArray[i][1])
    if(chronosArray[i][2].length == 1) {
      $('#chrono_' + chronosArray[i][0] + ' #minutes').text('0' + chronosArray[i][2])
    } else {
      $('#chrono_' + chronosArray[i][0] + ' #minutes').text(chronosArray[i][2])
    }
    if(chronosArray[i][3].length == 1) {
      $('#chrono_' + chronosArray[i][0] + ' #seconds').text('0' + chronosArray[i][3])
    } else {
      $('#chrono_' + chronosArray[i][0] + ' #seconds').text(chronosArray[i][3])
    }

    setInterval(function() {
      if(parseInt(chronosArray[i][3]) < 59) {
        seconds[i]++
      } else if(parseInt(chronosArray[i][3]) == 59) {
        if(parseInt(chronosArray[i][2]) < 59) {
          minutes[i]++
          seconds[i] = 0
        } else if(m == 59) {
          hours[i]++
          minutes[i] = 0
          seconds[i] = 0
        }
      }
      $('#chrono_' + chronosArray[i][0] + ' #hours').text(chronosArray[i][1])
      if(chronosArray[i][2].length == 1) {
        $('#chrono_' + chronosArray[i][0] + ' #minutes').text('0' + chronosArray[i][2])
      } else {
        $('#chrono_' + chronosArray[i][0] + ' #minutes').text(chronosArray[i][2])
      }
      if(chronosArray[i][3].length == 1) {
        $('#chrono_' + chronosArray[i][0] + ' #seconds').text('0' + chronosArray[i][3])
      } else {
        $('#chrono_' + chronosArray[i][0] + ' #seconds').text(chronosArray[i][3])
      }
    }, 1000);
  }
}
