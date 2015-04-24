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

function user_uploader() {
  // Update image preview
  $("#user_picture_attributes_avatar").change(function(){
    readFileImage(this, "#user-form-image");
  });
}

function readFileImage(input, element) {
  if (input.files && input.files[0]) {

    // Create a new file reader
    var reader = new FileReader();

    // Validate if element (image) exists
    reader.onload = function (e) {

      // Build image with its container
      if ( ! $(element).attr('src')) {

        var filename      = input.files[0].name;
        var container_ini = "<div class= 'avatar-previews'>";
        var container_end = "</div>";
        var img           = "<img id='user-form-image' src='' alt='"
                            + filename + "' />";
        var paragraph_ini = "<p>";
        var paragraph_end = "</p>";
        var html_code     = container_ini + img + paragraph_ini + filename
                            + paragraph_end + container_end;
        // Append just created elements
        var pre_element   = "span#user-file-upload";
        $(pre_element).after(html_code);
        // Set new image element
        element = $("img#user-form-image");
      }

      // Set new image src
      $(element).attr('src', e.target.result)
                .attr('width', 118)
                .attr('heigth', 118);
    }

    // Read image
    reader.readAsDataURL(input.files[0]);

    // Set filename
    $(".avatar-previews p").text(input.files[0].name);
  }
}

function rich_editor() {
    if (gon.full_locale != 'en-US') {
        locale = gon.full_locale;
    } else {
        locale = '';
    }

    var summer_note;
    summer_note = $('.summernote');
    summer_note.summernote({
      height: 500,
      lang: locale,
      codemirror: {
        lineNumbers: true,
        tabSize: 2,
        theme: "solarized light"
      }
    });
    summer_note.code(summer_note.val());
    return summer_note.closest('form').submit(function() {
      summer_note.val(summer_note.code());
      return true;
    });
}

/**
 * Loader
 */
$(function(){

  form_actions();
  form_list_grid();
  custom_select2();
  user_uploader();
  rich_editor();

});
