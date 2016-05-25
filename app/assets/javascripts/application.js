//= require jquery
//= require jquery_ujs
//= require foundation
//= require refile
//= require lodash
//= require video
//= require jquery.turbolinks
//= require turbolinks
//= require_self
//= require_tree .

$.turbo.use('page:load', 'page:fetch', 'page:update', 'opened.fndtn.reveal');
$(function() { $(document).foundation(); });
