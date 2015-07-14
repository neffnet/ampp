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
  $('.scroller').slick({
    infinite: false,
    slidesToShow: 4,
  });

  $('.album-link').on('click', function(){
    console.log('click');
    title = $(this).find('img').attr('alt');
    id = $(this).attr('data-id');
    $('#galleryTitle').html(title);
    $.ajax({
      url: '/get_album/' + id,
      method: 'POST',
      dataType: 'json',
      success: function(data){
        // first image
        $('.mainImage').html("<img src='" + data[0].full + "' alt='" + data[0].name + "' width='" + data[0].width + "' height='" + data[0].height + "' />");
        $('.caption').html(data[0].name);

        // remove previous thumbnails and click handler
        // $('.scroller').unslick();
        $('.slick-slide').remove();
        // $('.scroller').slick({
        //   infinite: false,
        //   slidesToShow: 4,
        // });
        // $('.slick-slide').off();
        // add the new thumbnails and new click handler
        $(data).each(function(){
          $('.scroller').slick('slickAdd', "<div><img src='" + this.thumb + "' width='50%' height='50%' /></div>");
        });
        $('.slick-slide').on('click', function(){
          console.log('click');
          index = $(this).attr('data-slick-index');
          $('.scroller').slick('slickGoTo', index, true);
          $('.caption').html(data[index].name);
          $('.mainImage').html("<img src='" + data[index].full + "' alt='" + data[index].name + "' width='" + data[index].width + "' height='" + data[index].height + "' />");
        });
      } // end success
    }); // end ajax
  });
    // end album click handler


};

$(document).ready(ready);
$(document).on('page:load', ready);