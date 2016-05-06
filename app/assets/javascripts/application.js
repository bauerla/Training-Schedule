// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui/core
//= require jquery.nicescroll
// require jquery-ui/datepicker
// require jquery-ui/datepicker-fi
//= require bootstrap-sprockets
//= require sweetalert2
// require turbolinks
//= require_tree .


var ready = function() {

  // Replacing default scrollbar
  $("html").niceScroll({ cursorcolor: "#5C6B5C",
                         cursorwidth: "7px",
                         autohidemode: false });

	console.log('datepicker initialized');
	$('.datepicker').datepicker({
		dateFormat: 'yy-mm-dd'
	});

	$('.datepicker').click(function(e) {
		// TODO, if any
	});

	$('.datepicker').on("input change", function(e) {
		console.log("Date changed: ", e.target.value);
		var targetClass = e.target.id;
		console.log("target class: " + targetClass);
		if (targetClass === "event_starttime_date") {
      $('#event_endtime_date').val(e.target.value);
		}
	});

	$('.event_day').on("click", function(e) {
		console.log("event_day clicked!");
	});

	/* flash message auto-close functions */
  function fadeAlert(){
    $('.alert-custom').removeClass('in');
  }

  function removeAlert(){
    $('.alert-custom').remove();
  }

  window.setTimeout(fadeAlert,5000);
  window.setTimeout(removeAlert,8000);

  /* Tooltips for buttons */
  $('.has-tooltip').tooltip();

};

$(document).ready(ready);
