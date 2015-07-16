window.App ||= {}

App.init = ->

  #flash messages
  $('.alert-box .close').on "click", ->
    $('.alert-box').fadeOut(500);

$(document).on "page:change", ->
  App.init()