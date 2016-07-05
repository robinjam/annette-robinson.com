$(document).on "turbolinks:click", ->
  $("body").addClass("wait")

$(document).on "turbolinks:load", ->
  $("body").removeClass("wait")
