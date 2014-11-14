$(document).on "page:change", ->
  $(".flash").delay(5000).fadeOut(1000)
  $("form").submit ->
    $(this).find("input[type=submit]").attr("disabled", "disabled")
