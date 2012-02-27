jQuery ->
  if $("body").is(".albums.show")
    $("<a>&lt; Back</a>").click(-> $(".main").animate { scrollLeft: 0 }, 1000)
      .addClass("back-button")
      .appendTo(".content")
