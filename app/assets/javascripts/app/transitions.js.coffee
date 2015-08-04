# streaming player clicker
$(document).on 'click', '#bc_player_clicker', ->
  console.log('clicker clicked')
  console.log(@)
  if !( $(@).hasClass("popped"))
    console.log('popping')
    y = $('#bc_player_clicker').offset().top - 20
    $('#bc_player').animate {
      right: '40px',
      top: y
    }, 1500, ->
      $("#bc_player_clicker").addClass("popped")
  else
    console.log('popping')
    $("#bc_player").animate {
      right: '-1000px'
    }, 1500, ->
      $("#bc_player_clicker").removeClass("popped")

# main content transitions
$(document).on 'click', '#nav li', ->
  console.log('click click, this is: ')
  console.log(@)
  return if $(@).hasClass('active')
  $('#nav').children().removeClass('active')
  $('#show-hide-area').children().fadeOut()
  $(@).addClass('active')
  i = $('#nav').children().index(@)
  console.log("click index #{i}")
  toShow = $('#show-hide-area').children().get(i)
  $(toShow).fadeIn()