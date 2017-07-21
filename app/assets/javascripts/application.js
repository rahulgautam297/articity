// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require jquery-ui/widgets/autocomplete
//= require_tree .
$(document).ready(function() {
	$(".thouWillBringDarkness").on("click", function() {
		$('.shallTurnToDarkness').show();
		$('.signUpForm').hide();
		$('.sellerSignUpForm').hide();
		$('body').css({"overflow":"hidden"});
	});
	$(".thouWillBringDarkness1").on("click", function() {
		$('.shallTurnToDarkness').show();
		$('.signInForm').hide();
		$('.sellerSignUpForm').hide();
		$('body').css({"overflow":"hidden"});
	});
	$(".thouWillBringDarkness2").on("click", function() {
		$('.shallTurnToDarkness').show();
		$('.signInForm').hide();
		$('.signUpForm').hide();
		$('body').css({"overflow":"hidden"});
	});
	$(function () {
  		$('[data-toggle="tooltip"]').tooltip()
	});
});
