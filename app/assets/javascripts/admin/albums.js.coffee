$(document).on "page:change", ->
  if $("body").is(".albums.show")
    $(".extra-buttons").hide();

    $("#albums").sortable({
      update: (event, ui) ->
        id = ui.item.attr("id").substring(6)
        index = parseInt(ui.item.index()) + 1
        $.post("/albums/" + id + "/move.json", { to: index }, null, 'html')
          .error -> location.reload()
      }).disableSelection()

    $("#images").sortable({
      opacity: 0.6,
      update: (event, ui) ->
        id = ui.item.attr("id").substring(6)
        index = parseInt(ui.item.index()) + 1
        $.post(location.pathname + "/images/" + id + "/move.json", { to: index }, null, 'html')
          .error -> location.reload()
    }).disableSelection()

    $("#images li")
      .mouseenter(-> $(this).find(".close-button").css("visibility", "visible"))
      .mouseleave(-> $(this).find(".close-button").css("visibility", "hidden"))

    $("#images li .close-button").click ->
      image = $(this).parent().parent()
      $.post(location.pathname + "/images/" + image.attr("id").substring(6) + ".json", { _method: "delete" }, null, 'html')
        .error -> location.reload()
      $(image).remove()

    $(".sidebar")
      .mouseenter(-> $(".extra-buttons").show())
      .mouseleave(-> $(".extra-buttons").hide())
