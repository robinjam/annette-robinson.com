Turbolinks.enableProgressBar()

$(document).on "page:before-change", ->
  $("#spinner").fadeIn()
  $("body > div > div").animate opacity: 0

$(document).on "page:change", ->
  $("#spinner").fadeOut()
  $("body > div > div")
    .css opacity: 0
    .animate opacity: 1
  $("img")
    .css opacity: 0
    .load ->
      $(this).animate opacity: 1
