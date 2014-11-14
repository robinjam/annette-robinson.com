$(document).on "page:change", ->
  if $("body").is(".album_images.new")
    $("<h2>Preview</h2><img id=\"preview\">").appendTo("div.content")

    $("#album_image_image_id").change ->
      $("img#preview").attr("src", image_urls[$(this).val()])

    $("#album_image_image_id").change()
    $("img#preview").show()
