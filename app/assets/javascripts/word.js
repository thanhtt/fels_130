var ready
ready = function () {
  $("#new_word, .edit_word").submit(function () {
    if ($('input:checkbox:checked').length === 0) {
      alert("Please choose a correct answer")
      return false
    }
    var check
     $('input:text[id^="word_answers_attributes"]').each(function(){
      if (this.value == "") {
        alert("answer is not empty")
        check = false
        return false
      }
     })
     if(check == false)
      return false

    return true
  })
  make_radio_from_checkbox()

  $("body").on("DOMNodeInserted", function () {
    make_radio_from_checkbox()
  })

  $("#filter_form").on("change", function () {
    $(this).submit()
  })
}

function make_radio_from_checkbox () {
  $(".answer_field").click(function () {
    $(".answer_field").not(this).attr("checked", false)
  })
}

$(document).ready(ready)
$(document).on("page:load", ready)
function checking() {
    $('input:text[id^="word_answers_attributes"]').each(function(){
       if (this.value == "") {
          alert("answer is not empty")

       }
    })
}
