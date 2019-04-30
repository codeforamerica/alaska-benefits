const followUpCheckBoxes = (function() {
  const fUQ = {
    init: function() {
      const checkBoxes = $("input:checkbox");
      const followUp = $('.question-with-follow-up__follow-up');

      const showChecked = function() {
        checkBoxes.each(function(index, value){
          const target = $("input[data-follow-up='" + value.dataset.followUpTarget + "']");
          if ($(value).is(':checked')) {
            followUp.show();
            target.parents(".form-group").show()
          } else {
            target.parents(".form-group").hide()
          }
        });
      };

      showChecked();

      // show or hide the follow up dropdown
      checkBoxes.change(function() {
        // keep visible if any checkboxes checked
        if (checkBoxes.is(":checked")) {
          followUp.show();
        } else {
          followUp.hide();
        }

        // show followup inputs
        showChecked();
      });

      // show errors
      if (followUp.find('div.field_with_errors').length > 0) {
        followUp.show();
        showChecked();
      }
    }
  };
  return {
    init: fUQ.init
  }
})();

$(document).ready(function () {
  followUpCheckBoxes.init();
});
