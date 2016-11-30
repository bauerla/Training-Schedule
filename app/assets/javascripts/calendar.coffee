# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  # Replacing default scrollbar
  $('.event_item').niceScroll cursorcolor: "#5C6B5C"

  # Click day (with events)
  $('td[data-link]').click ->
    console.log "data td clicked"
    window.location = $(this).data("link")

  $('.calendar td').hover ( ->
    $(this).children('.day_header_content').find('.add_event_link').addClass 'hover'
    return
    ), ->
    $(this).children('.day_header_content').find('.add_event_link').removeClass 'hover'
    return

$(document).ready ready
