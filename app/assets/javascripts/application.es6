//= require jquery
//= require jquery_ujs
//= require foundation
//= require lodash
//= require turbolinks
//= require modules
//= require_self

// Bind javascript code on any page load event
$(document).on('ready page:load', function(event) {
  // Initialize Foundation
  $(this).foundation();

  // Call the default export function on all modules
  module.each(function(ready) {
    if (typeof(ready) === 'function') {
      ready(event);
    }
  });
});
