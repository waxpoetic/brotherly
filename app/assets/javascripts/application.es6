//= require jquery
//= require jquery_ujs
//= require foundation
//= require refile
//= require lodash
//= require turbolinks
//= require_self

import $ from 'jquery';
import autocompleteSearch from 'searches';
import inlineFormResponse from 'subscribers';

const DOM_READY = 'ready page:load page:fetch page:update opened.fndtn.reveal';

export default function() {
  $(document).on(DOM_READY, function() {
    $(this).foundation();
    autocompleteSearch();
    inlineFormResponse();
  });
}
