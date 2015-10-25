//= require jquery
//= require jquery_ujs
//= require foundation
//= require refile
//= require jquery_nested_form
//= require lodash
//= require jquery.flash
//= require jquery.turbolinks
//= require turbolinks
//= require_self
//= require_tree .

$.turbo.use('page:load', 'page:fetch', 'ajax:complete');
$(function() { $(document).foundation(); });
