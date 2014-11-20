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
      update: (event, ui) ->
        id = ui.item.data("image-id")
        index = parseInt(ui.item.index()) + 1
        $.post(location.pathname + "/images/" + id + "/move.json", { to: index }, null, 'html')
          .error -> location.reload()
    }).disableSelection()

    $("#images .delete-button").click ->
      $(this).parent().hide()

    $("a[data-remote]").on "ajax:error", (e, data, status, xhr) ->
      location.reload()

    $(".sidebar")
      .mouseenter(-> $(".extra-buttons").show())
      .mouseleave(-> $(".extra-buttons").hide())
