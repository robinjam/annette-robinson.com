$(document).on "page:change", ->
  if $("body").is(".albums.show")
    $(".extra-buttons").hide();

    $("#albums").sortable({
      axis: 'y'
      revert: true
      start: (e, ui) ->
        ui.placeholder.width(ui.item.width())
      update: (event, ui) ->
        id = ui.item.data("album-id")
        index = parseInt(ui.item.index()) + 1
        $.post("/albums/" + id + "/move.json", { to: index }, null, 'html')
          .error -> location.reload()
      }).disableSelection()

    $("#images").sortable({
      tolerance: 'pointer'
      revert: true
      update: (event, ui) ->
        id = ui.item.data("image-id")
        index = parseInt(ui.item.index()) + 1
        $.post(location.pathname + "/images/" + id + "/move.json", { to: index }, null, 'html')
          .error -> location.reload()
    }).disableSelection()

    $("#images li")
      .mouseenter(-> $(this).find(".fa-times").css("visibility", "visible"))
      .mouseleave(-> $(this).find(".fa-times").css("visibility", "hidden"))

    $("#images .fa-times").css("visibility", "hidden")

    $("#images li .fa-times").click ->
      image = $(this).parent()
      $.post(location.pathname + "/images/" + image.data("image-id") + ".json", { _method: "delete" }, null, 'html')
        .error -> location.reload()
      $(image).remove()

    $(".sidebar")
      .mouseenter(-> $(".extra-buttons").show())
      .mouseleave(-> $(".extra-buttons").hide())
