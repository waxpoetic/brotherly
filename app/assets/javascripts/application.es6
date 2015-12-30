//= require jquery
//= require jquery_ujs
//= require foundation
//= require refile
//= require lodash
//= require turbolinks
//= require loader
//= require_tree .
//= require_self

const DOM_READY = 'page:load page:fetch page:update opened.fndtn.reveal';

$(document).on(DOM_READY, function() {
  $(this).foundation();
  module.exports.forEach((module) => module());
});
