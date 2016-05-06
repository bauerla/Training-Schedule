# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  # Replacing default scrollbar
  $('.event_item').niceScroll cursorcolor: '#3C4B3C'

  # Click day (with events)
  $('td[data-link]').click ->
    console.log "data td clicked"
    window.location = $(this).data("link")

$(document).ready ready
