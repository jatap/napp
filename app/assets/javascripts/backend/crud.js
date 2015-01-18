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

/**
 * Loader
 */
$(function(){

  form_actions();
  form_list_grid();
  custom_select2();

});
