# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Override default confirm dialog (Sweet Alert plugin) 
# http://t4t5.github.io/sweetalert/

$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look below for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
    swal {
      title: $('#deletion').data('title')
      text: $('#deletion').data('msg')
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Delete'
      cancelButtonText: 'Cancel'
      closeOnConfirm: false
      closeOnCancel: false
      timer: 15000
    }, (isConfirm) ->
      if isConfirm
        swal 'Deleted!', 'Student has been deleted!.', 'success', $.rails.confirmed link
      else
        swal 'Cancelled', 'Student delete has been cancelled', 'error'
      return