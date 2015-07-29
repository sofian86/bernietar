ready = ->

  # We won't be getting any response back from Facebook so we're being nice
  # and assuming they've cropped and saved the Bernietar
  $('#crop-facebook').click ->
    $('#steps').addClass('hide')
    $('#final').removeClass('hide')

$(document).ready(ready)
$(document).on('page:load', ready)
