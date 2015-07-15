ready = ->

  # Gives us full width text
  $('.fit-text').fitText(0.6, {maxFontSize: '70px'});

$(document).ready(ready)
$(document).on('page:load', ready)