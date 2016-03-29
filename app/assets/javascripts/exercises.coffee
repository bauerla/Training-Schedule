# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.exercises p #update').click ->
    elementId = $(this).closest('p').find('#exercise_id')
    id = elementId.attr('value')
    console.log id
    $('.panel_exercises input[name=current_ex]').val(id)
    return

$(document).ready ready
