class Carousel
  constructor: (element, params ) ->
    console.log('Carousel constructor...')
    @params = params
    @element = element
    $(element).slick( $.merge(_defaultParams, params) ) 

  _defaultParams =
    {
      dots: true,
      arrows: true,
      infinite: false,
      slidesToScroll: 2
    }

  loadGallery: (id, name) ->
    console.log('loadGalery triggered')
    # set gallery name
    $("#galleryTitle").html name
    # unload previous gallery

    $.ajax
      url: "/get_album/#{id}"
      method: "POST"
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        alert("Sorry, we couldn't get this from Facebook. Details: #{textStatus}")
      success: (data) -> 
        console.log('ajax success')
        console.log("data: " + data)
        # set first image caption
        $(".caption").html("#{data[0].name}")
        
        for image in data
          console.log("image: ")
          console.log(image)
          # lazy load main images
          $(".mainImage").slick("slickAdd", "<img src='#{image.full}' alt='#{image.name}' />")
          # thumbnails
          $(".scroller").slick("slickAdd", "<img src='#{image.thumb}' alt='#{image.name}' width='50%' height='50%' />")

$(document).on "click", "[data-behavior=loadGallery]", ->
  console.log('data-behavior listenter')
  window.scroller.loadGallery($(@).data('id'), $(@).data('name'))

$(document).on "page:change", ->
  console.log('page:change triggered on carousel class')
  return unless $(".c-sites.a-show").length > 0
  
  window.scroller = new Carousel $(".scroller"), {
    slidesToShow: 5,
    centerMode: true,
    focusOnSelect: true,
    asNavFor: ".mainImage"
  }
  window.mainImage = new Carousel $(".mainImage"), {
    slidesToShow: 1,
    slidesToScroll: 1,
    dots: false,
    arrows: false,
    fade: true,
    asNavFor: ".scroller"
  }



