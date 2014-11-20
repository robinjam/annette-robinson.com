$(document).on "page:before-change", ->
  $("body").addClass("wait")

$(document).on "page:change", ->
  $("body").removeClass("wait")
