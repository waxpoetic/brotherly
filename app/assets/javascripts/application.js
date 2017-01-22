//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require refile
//= require lodash
//= require video
//= require videojs-contrib-hls
//= require turbolinks
//= require_tree .
//= require_self

$(document).on('ready page:change', function(event) {
  module.init($(event.currentTarget));
});
