//= require select2-full

$('.js-select-userids').select2({
  tags: true
})

;$('.js-select-userids').on('select2:select', function() {
  let value = [];
  let list = $(this).find(':selected');  if(list) {
    list.each(function(i, v) {
      value = value.concat(JSON.parse(v.value));
    })
  }  value = Array.from(new Set(value));
  $(this).val(value).trigger('change');
});
