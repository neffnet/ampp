window.App ||= {}

App.init = ->
  console.log('app init')

  #flash messages
  $('.alert-box .close').on "click", ->
    $('.alert-box').fadeOut(500);

  #streaming player clicker
  $('#bc_player_clicker').on 'click', ->
    $('#bc_player').animate({
      right: '40px'
    }, 1500);

$(document).on "page:change", ->
  App.init()