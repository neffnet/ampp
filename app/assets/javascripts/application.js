//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require jquery.slick
//= require_tree .

$(function(){ $(document).foundation(); });
var ready;
ready = function(){

  // flash messages
  $('.alert-box .close').click(function(){
    $('.alert-box').fadeOut(500);
  });

  // photo gallery
  $('.album-link').on('click', function(){
    title = $(this).find('img').attr('alt');
    id = $(this).attr('data-id');
    $('#galleryTitle').html(title);    
    var images;
    $.ajax({
      url: '/get_album/' + id,
      method: 'POST',
      dataType: 'json',
      success: function(data){
        $.each(data, function(){
          // append thumbnail to scroller
    
        });
      }
    });
  });


};
$(document).ready(ready);
$(document).on('page:load', ready);