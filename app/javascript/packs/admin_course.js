var lessonBox;

$(window).on("turbolinks:load", function(){
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();
  if ($("#sortable .lesson-box").length == 1) {
    $(".remove-lesson").hide();
  }
  lessonBox = $("#sortable .lesson-box").first().html();
});

$(document).on("click", ".btn-add-lesson", function() {
  let newBox = $(lessonBox);
  addLesson(newBox);
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
  let btnDeleteLesson = $(this);
  $('#confirm-delete').on('shown.bs.modal', function() {
    deleteModal = $(this);
    $(document).on("click", ".btn-ok", function () {
      btnDeleteLesson.parent().find(".delete-lesson").val("true");
      btnDeleteLesson.closest(".lesson-box").hide();
      deleteModal.modal('hide');
    })
  });
})

$(document).on("click", ".btn-edit-course", function () {
  $("#sortable").find(".lesson-box").filter(function () {
    return $(this).find(".delete-lesson").val() == "false"
  }).each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
  })
  $(this).submit();
})

function change_name_lesson(lesson, numberLesson) {
  lesson.find("input").each(function () {
    if ($(this).attr("name").includes("course[lessons_attributes]")) {
      $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0,$(this).attr("name").indexOf(']', 26)),
      "course[lessons_attributes][" + numberLesson));
    }
  })
  lesson = lesson.html();
}

function addLesson(newBox) {
  var numberLesson = $("#sortable .lesson-box").length;
  var parent = "<div class='lesson-box lesson-field ui-sortable-handle'></div>"
  newBox.find(".lesson_seq").val(numberLesson +1);
  change_name_lesson(newBox, numberLesson, 0, 0);
  $("#sortable").append(parent);
  $("#sortable .lesson-box").last().append(newBox);
  $(".remove-lesson").show();
}
