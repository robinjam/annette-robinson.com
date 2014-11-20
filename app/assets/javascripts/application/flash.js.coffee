$(document).on "page:change", ->
  $(".flash").delay(5000).slideUp()
  $("form").submit ->
    $(this).find("input[type=submit]").attr("disabled", "disabled")
