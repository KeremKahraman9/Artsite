// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)


'----------------------------------------------------------------'

var new_scroll_position = 0;
var last_scroll_position;
var navbar = document.getElementById("navbar");

window.addEventListener('scroll', function(e) {
  last_scroll_position = window.scrollY;

  // Scrolling down
  if (new_scroll_position < last_scroll_position && last_scroll_position > 10) {
    // navbar.removeClass('slideDown').addClass('slideUp');
    navbar.classList.remove("slideDown");
    navbar.classList.add("slideUp");

  // Scrolling up
  } else if (new_scroll_position > last_scroll_position) {
    // navbar.removeClass('slideUp').addClass('slideDown');
    navbar.classList.remove("slideUp");
    navbar.classList.add("slideDown");
  }

  new_scroll_position = last_scroll_position;
});
