class Carousel
  constructor: ({ element, params }) ->
    @params = params
    @element = element
    $(element).slick $(defaultParams).merge(params) 

  defaultParams =
    {
      dots: true,
      arrows: true,
      infinite: false,
      slidesToScroll: 2
    }

  loadGallery: (id, name) ->
    # set gallery name
    $("#galleryTitle").html name
    # unload previous gallery

    $.ajax
      url: "/get_album/#{id}"
      method: "POST"
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        alert("Sorry, we couldn't get this from Facebook. Details: #{textStatus}")
      success: ->
        # set first image caption
        $(".caption").html("#{data[0].name}")
        
        for image in data
          # lazy load main images
          $(".mainImage").slick("slickAdd", "<img data-lazy='#{image.full}' alt='#{image.name}' />")
          # thumbnails
          $(".scroller").slick("slickAdd", "<img source='#{image.thumb}' alt='#{image.name}' width='50%' height='50%' />")

$(document).on "page:change", ->
  return unless $(".c-sites.a-show").length > 0
  
  scroller = scroller ? new Carousel $(".scroller"), {
    slidesToShow: 5,
    centerMode: true,
    focusOnSelect: true,
    asNavFor: ".mainImage"
  }
  mainImage = mainImage ? new Carousel $(".mainImage"), {
    slidesToShow: 1,
    slidesToScroll: 1,
    dots: false,
    arrows: false,
    fade: true,
    asNavFor: ".scroller"
  }



