/**
 * Functions
 */
function form_actions() {
    $(".fa-navicon").click(function() {
        $(".form-actions").toggle();
    });
}

function form_list_grid() {
    $('.datatable').DataTable({
        dom: 'Rlfrtip',
        stateSave: true,
        responsive: true,
        processing: true,
        serverSide: true,
        ajax: $('.datatable').data('source'),
        pagingType: "full",
        columnDefs: [
            { sortable: false, targets: -1 }
        ],
        lengthMenu: [5, 10, 25, 50, 100, 200],
        language: {
            url:               "",
            processing:        "<i class='fa fa-refresh fa-spin'></i> " + I18n.t("crud.ajax.processing"),
            search:            "_INPUT_",
            searchPlaceholder: I18n.t("crud.search.placeholder"),
            lengthMenu:        "_MENU_",
            info:              " _START_/_END_ <i class='fa fa-database'></i> [_TOTAL_]",
            infoEmpty:         "<i class='fa fa-filter'></i> 0/0 [0]",
            infoFiltered:      I18n.t("crud.ajax.info_filtered"),
            infoPostFix:       "",
            infoThousands:     ".",
            loadingRecords:    I18n.t("crud.ajax.loading"),
            zeroRecords:       I18n.t("crud.ajax.empty_results"),
            emptyTable:        I18n.t("crud.ajax.empty_table"),
            paginate: {
                first:         "<i class='fa fa-angle-left'></i>",
                previous:      "<i class='fa fa-angle-double-left'></i>",
                next:          "<i class='fa fa-angle-double-right'></i>",
                last:          "<i class='fa fa-angle-right'></i>"
            },
            aria: {
                sortAscending:  I18n.t("crud.ajax.sort_ascending"),
                sortDescending: I18n.t("crud.ajax.sort_descending")
            }
        }
    });
}

function custom_select2() {
    $("select").select2({
        dropdownCssClass: 'dropdown-inverse'
    });
}

function upload_images() {

  Dropzone.autoDiscover = false;

  // Set default options
  $(".dropzone").dropzone({

    // Options
    maxFiles: 1,
    maxFilesize: 1,
    paramName: "user[avatar]",
    addRemoveLinks: true,
    previewsContainer: '.dropzone-previews',
    autoProcessQueue: true,

    // Translations
    dictDefaultMessage: I18n.t('crud.tabs-content.media.input.file'),
    dictFallbackMessage: I18n.t('crud.tabs-content.media.fallback-message'),
    dictFallbackText: I18n.t('crud.tabs-content.media.fallback-text'),
    dictInvalidFileType: I18n.t('crud.tabs-content.media.error.invalid-file-type'),
    dictFileTooBig: I18n.t('crud.tabs-content.media.error.file-too-big'),
    dictResponseError: I18n.t('crud.tabs-content.media.error.response'),
    dictCancelUpload: I18n.t('crud.tabs-content.media.cancel.upload'),
    dictCancelUploadConfirmation: I18n.t('crud.tabs-content.media.cancel.upload-confirmation'),
    dictRemoveFile: I18n.t('crud.tabs-content.media.input.checkbox'),
    dictMaxFilesExceeded: I18n.t('crud.tabs-content.media.error.max-files'),

    success: function(file, response, event) {
      // Update image src
      var avatar = $(".avatar-previews .attachment");

      if (avatar.length + 0) {
        var new_src_array = avatar.attr("src").split("/");
        var old_id = new_src_array[new_src_array.length - 2];
        var old_filename = new_src_array[new_src_array.length - 1];

        new_src_array[new_src_array.length - 2] = response.avatar_id;
        new_src_array[new_src_array.length - 1] = encodeURI(response.avatar_filename);
        var new_src = new_src_array.join("/");
      }

      avatar.attr("src", new_src);
    }
  });

  // Move generated div inside crud edit media tag
  var dropzone_message      = $(".dz-message");
  var dropzone_message_html = "<label class='control-label control-label-file-input'>"
    + dropzone_message.prop('outerHTML') + "</label>";
  var media_tab             = $("#media #user_avatar");
  media_tab.after(dropzone_message_html);
  dropzone_message.remove();

}

/**
 * Loader
 */
$(function(){

  form_actions();
  form_list_grid();
  custom_select2();
  upload_images();

});
