window.App ||= {}

App.init = ->
  console.log('app init')

  #flash messages
  $('.alert-box .close').on "click", ->
    $('.alert-box').fadeOut(500);

$(document).on "page:change", ->
  App.init()