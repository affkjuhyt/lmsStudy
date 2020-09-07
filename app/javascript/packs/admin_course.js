var lesson_box;

$(window).on("turbolinks:load", function(){
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();
  if ($("#sortable .lesson-box").length == 1) {
    $(".remove-lesson").hide();
  }
  lesson_box = $("#sortable .lesson-box").first().html();
});

$(document).on("click", ".btn-add-lesson", function() {
  new_box = $(lesson_box);
  addLesson(new_box);
});

$(document).on("click", ".remove-lesson", function() {
  parent = $(this).closest("#sortable");
  number_lesson = $("#sortable .lesson-box").length;
  $(this).closest(".lesson-box").remove();
  if (parent.find(".lesson-box").length == 1) {
    parent.find(".remove-lesson").hide();
  }
});

$(document).on("click", ".btn-submit-course", function () {
  $("#sortable").find(".lesson-box").each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
  })
  $(".form-course").submit()
})

$(document).on("click", ".delete-lesson-btn", function () {
  btn_delete_lesson = $(this);
  $('#confirm-delete').on('shown.bs.modal', function() {
    delete_modal = $(this);
    $(document).on("click", ".btn-ok", function () {
      btn_delete_lesson.parent().find(".delete-lesson").val("true");
      btn_delete_lesson.closest(".lesson-box").hide();
      delete_modal.modal('hide');
    })
  });
})

$(document).on("click", ".btn-edit-course", function () {
  debugger
  $("#sortable").find(".lesson-box").filter(function () {
    return $(this).find(".delete-lesson").val() == "false"
  }).each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
  })
  $(this).submit();
})

function change_name_lesson(lesson, number_lesson) {
  lesson.find("input").each(function () {
    if ($(this).attr("name").includes("course[lessons_attributes]")) {
      $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0,$(this).attr("name").indexOf(']', 26)),
      "course[lessons_attributes][" + number_lesson));
    }
  })
  lesson = lesson.html();
}

function addLesson(new_box) {
  var number_lesson = $("#sortable .lesson-box").length;
  var parent = "<div class='lesson-box lesson-field ui-sortable-handle'></div>"
  new_box.find(".lesson_seq").val(number_lesson +1);
  change_name_lesson(new_box, number_lesson, 0, 0);
  $("#sortable").append(parent);
  $("#sortable .lesson-box").last().append(new_box);
  $(".remove-lesson").show();
}
