$(document).on "page:change", ->
  $("form").submit ->
    $(this).find("input[type=submit]").attr("disabled", "disabled")
