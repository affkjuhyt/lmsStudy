$(document).on("click", ".delete-lesson-btn", function () {
  btnDeleteLesson = $(this);
  $('#confirm-delete').on('shown.bs.modal', function() {
    deleteModal = $(this);
    $(document).on("click", ".btn-ok", function () {
      btnDeleteLesson.parent().find(".delete-lesson").val("true");
      btnDeleteLesson.closest(".lesson-box").hide();
      deleteModal.modal('hide');
    })
  });
})

$(document).on("click", ".delete-question-btn", function () {
  btnDelete = $(this);
  $('#confirm-delete').on('shown.bs.modal', function() {
    confirmModal = $(this);
    $(document).on("click", ".btn-ok", function () {
      btnDelete.parent().find(".delete-question").val("true");
      btnDelete.parent().hide();
      confirmModal.modal('hide');
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
