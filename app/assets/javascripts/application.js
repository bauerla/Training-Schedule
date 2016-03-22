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
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui/datepicker
//= require jquery-ui/datepicker-fi
//= require sweetalert2
//= require turbolinks
//= require_tree .

jQuery.noConflict();

jQuery(document).ready(function($) {
	console.log('datepicker initialized');
	$('.datepicker').datepicker({
		dateFormat: 'yy-mm-dd'
	});

	$('.datepicker').click(function(e) {
		// TODO, if any
	});

	$('.datepicker').on("input change", function(e) {
		console.log("Date changed: ", e.target.value);
		var targ = e.target.parentElement.closest("div");
		var targetClass = targ.getAttribute('class');
		console.log("target class: " + targetClass);
		if (targetClass === "starttime_field") {
			$("div.endtime_field .datepicker").val($("div.starttime_field .datepicker").val());
		}
	});

	$('.event_day').on("click", function(e) {
		console.log("event_day clicked!");
	});

});