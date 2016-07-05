$(document).on "turbolinks:load", ->
  if $("body").is(".images.index")
    $("body").append $("<img id='preview'>")

    $("tr.image").mouseenter ->
      $("img#preview")
        .show()
        .attr("src", image_urls[$(this).attr("data-imageid")])

    $(document).mousemove (e) ->
      $("img#preview").css {
        top: (e.pageY - $("img#preview").height()/2) + "px",
        left: (e.pageX + 10) + "px"
      }

    $("table#images").mouseleave ->
      $("img#preview").hide()
