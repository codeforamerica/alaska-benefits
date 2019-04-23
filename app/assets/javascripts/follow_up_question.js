var followUpQuestion = (function() {
  var fUQ = {
    init: function() {
      // The builder only applies styles to underlying elements, while we want to hide the whole form group.
      $('.question-with-follow-up__follow-up .form-group').hide();

      // add click listeners to initial question inputs
      $('.question-with-follow-up__question').click(function(e) {

        // show the follow up if there are any checkboxes clicked
        if ($("input:checkbox:checked").length > 0)
        {
          $('.question-with-follow-up__follow-up').show();
        }
        else
        {
          $('.question-with-follow-up__follow-up').hide();
        }

        // show and hide the follow up inputs
        data_target = e.target.attributes["follow-up-target"]["value"];
        selector = "*[follow-up='" + data_target + "']";
        if (e.target["checked"]) {
          $(selector).parent().show();
        } else {
          $(selector).parent().hide();
        }
      });
    }
  };
  return {
    init: fUQ.init
  }
})();

$(document).ready(function () {
  followUpQuestion.init();
});