var followUpCheckboxes = (function() {
  var fUQ = {
    init: function() {

      // show or hide the follow up dropdown
      $("input:checkbox").change(function(_){
        // keep visible if any checkboxes checked
        if ($("input:checkbox").is(":checked")) {
          $('.question-with-follow-up__follow-up').show();
        } else {
          $('.question-with-follow-up__follow-up').hide();
        }

        // show followup inputs
        show_checked();
      });

      // show errors
      if ($(".field_with_errors").length > 0) {
        $(".question-with-follow-up__follow-up").show();
        // show followup inputs
        show_checked();
      }
    }
  };
  return {
    init: fUQ.init
  }
})();

$(document).ready(function () {
  followUpCheckboxes.init();
});

function show_checked(){
  $("input:checkbox").each(function(index, value){
    target = $("input[data-follow-up='" + value.dataset.followUpTarget + "']");
    if ($(value).is(':checked')) {
      target.parents(".form-group").show()
    } else {
      target.parents(".form-group").hide()
    }
  });
}
