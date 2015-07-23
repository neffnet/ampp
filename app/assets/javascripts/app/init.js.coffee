window.App ||= {}

App.init = ->
  console.log('app init')

  #flash messages
  $('.alert-box .close').on "click", ->
    $('.alert-box').fadeOut(500);

  $(".reveal-modal").on "opened", ->
    console.log('reveal opened, redrawing gallery')
    $(".scroller").slick("setPosition", 0)
    $(".mainImage").slick("setPosition", 0)

$(document).on "page:change", ->
  App.init()