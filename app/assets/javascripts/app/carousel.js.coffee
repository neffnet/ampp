class Carousel

  image_data = []

  constructor: (@element, params ) ->
    $(@element).slick(params)
    
  loadGallery: (id, name) ->
    console.log('loadGalery triggered')
    # set gallery name
    $("#galleryTitle").html name
    # unload previous gallery
    $(".scroller").find(".slick-slide").remove()

    self = @
    $.ajax
      url: "/get_album/#{id}"
      method: "POST"
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        alert("Sorry, we couldn't get this from Facebook. Details: #{textStatus}")
      success: (data) -> 
        console.log('ajax success')
        console.log(data)
        self.image_data = data
        console.log('self.image_data is: ')
        console.log(self.image_data)
        # set first image and caption
        self.changeImage(0)
        
        # $('.mainImage').html("<img src='#{data[0].full}' alt='#{data[0].name}' width='#{data[0].width}' height='#{data[0].height}' />")
        # set first image caption
        # if data[0].name
        #   $(".caption").html("#{data[0].name}")
        # else
        #   $(".caption").empty()
        
        # thumbnails        
        for image in data
          $(".scroller").slick("slickAdd", "<div><img src='#{image.thumb}' alt='#{image.name}' width='50%' height='50%' /></div>")

  changeImage: (index) =>
    console.log("changing the image... index #{index}")
    console.log(@image_data[index])
    $('.mainImage').html("<img src='#{@image_data[index].full}' alt='#{@image_data[index].name}' width='#{@image_data[index].width}' height='#{@image_data[index].height}' />")
    if @image_data[index].name
      $(".caption").html("#{@image_data[index].name}")
    else
      $(".caption").empty()



$(document).on "click", "[data-behavior=loadGallery]", ->
  console.log('loading gallery...')
  window.scroller.loadGallery($(@).data('id'), $(@).data('name'))

$(document).on "click", ".scroller .slick-slide", ->
  window.scroller.changeImage($(@).data('slick-index'))

$(document).on "page:change", ->
  console.log('page:change triggered on carousel class')
  return unless $(".c-sites.a-show").length > 0
  
  window.scroller ||= new Carousel $(".scroller"), {
    slidesToShow: 5,
    fade: false,
    focusOnSelect: true,
    centerMode: true,
    arrows: true,
    infinite: true,
    slidesToScroll: 3
  }

