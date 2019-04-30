const fileUpload = (function () {
  return {
    init: function () {
      const uploadFileButton = $('.upload-file-button');
      const fileInput = $('input:file');

      const addDeleteFileListener = function() {
        $('.delete-file-link').click(function (e) {
          e.preventDefault();
          $('.uploaded-file-detail').remove();
          fileInput.val(null);
          uploadFileButton.show();
        });
      };

      uploadFileButton.click(function (e) {
        e.preventDefault();
        fileInput.click();
      });

      fileInput.on('change', function () {
        $('.uploaded-files').append(HandlebarsTemplates['file_uploading']);
        const uploadedContext = {
          filename: this.files[0].name
        };
        const uploadedFileDetailHtml = HandlebarsTemplates['uploaded_file_detail'](uploadedContext);
        $('#uploading-file-detail').replaceWith(uploadedFileDetailHtml);
        uploadFileButton.attr('style', 'display: none !important;');
        addDeleteFileListener();
      });
    }
  }
})();

$(document).ready(function () {
  fileUpload.init();
});
