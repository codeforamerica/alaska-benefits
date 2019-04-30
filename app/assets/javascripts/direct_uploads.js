var directUpload = (function () {
    return {
        init: function () {
            var addDeleteFileListener = function() {
                $('.delete-file-link').each(function (index, deleteFileLink) {
                    deleteFileLink.addEventListener('click', function (e) {
                        e.preventDefault();
                        deleteFileLink.closest('.uploaded-file-detail').remove();
                        $("input:file").val("")
                        $('.upload-file-button').show();
                    });
                });
            };

            $('input[type=file]').each(function (index, fileInput) {
                $('.upload-file-button').each(function (index, uploadFileButton) {
                    uploadFileButton.addEventListener('click', function (e) {
                        e.preventDefault();
                        fileInput.click();
                    });
                });

                fileInput.addEventListener('change', function (e) {
                  file = this.files[0];
                  var uploadingHtml = HandlebarsTemplates['file_uploading'];
                  $('.uploaded-files').append(uploadingHtml);

                  var uploadedContext = {
                    filename: file.name
                  };
                  var uploadedFileDetailHtml = HandlebarsTemplates['uploaded_file_detail'](uploadedContext);
                  $('#uploading-file-detail').replaceWith(uploadedFileDetailHtml);
                  $('.upload-file-button').attr('style', 'display: none !important;');
                  addDeleteFileListener();
                });
            });
        }
    }
})();

$(document).ready(function () {
    directUpload.init();
});
