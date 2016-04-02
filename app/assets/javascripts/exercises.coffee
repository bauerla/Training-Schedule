# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  # Currently selected element id to the hidden tag_field
  $('.exercise #update').click ->
    elementId = $(this).closest('.exercise').find('#exercise_id')
    id = elementId.attr('value')
    console.log id
    $('.exercises_container input[name=current_ex]').val(id)
    return

  # Disables other exercise objects update mode if present
  $('.update_ex_cancel').click ->
    $(this).closest('.update_form').toggle(false)
    $(this).closest('.update_form').prev('.exercise').toggle(true)
    return

$(document).ready ready
