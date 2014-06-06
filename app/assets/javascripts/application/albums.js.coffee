jQuery ->
  if $("body").is(".albums.show")
    $("<a>◀︎</a>").click(-> $(".main").animate { scrollLeft: 0 }, 1000)
      .addClass("back-button")
      .appendTo(".content")
