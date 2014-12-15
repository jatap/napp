function form_actions(){
    $(".fa-navicon").click(function() {
        $(".form-actions").toggle();
    });
}

function form_list_grid(){
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
            processing:        "Procesando...",
            search:            "_INPUT_",
            searchPlaceholder: "...",
            lengthMenu:        "_MENU_",
            info:              " _START_/_END_ <i class='fa fa-database'></i> [_TOTAL_]",
            infoEmpty:         "<i class='fa fa-filter'></i> 0/0 [0]",
            infoFiltered:      "(filtrado de un total de _MAX_ registros)",
            infoPostFix:       "",
            infoThousands:     ".",
            loadingRecords:    "Cargando...",
            zeroRecords:       "No se encontraron resultados",
            emptyTable:        "Ningún dato disponible en esta tabla",
            paginate: {
                first:         "<i class='fa fa-angle-left'></i>",
                previous:      "<i class='fa fa-angle-double-left'></i>",
                next:          "<i class='fa fa-angle-double-right'></i>",
                last:          "<i class='fa fa-angle-right'></i>"
            },
            aria: {
                sortAscending:  ": Activar para ordenar la columna de manera ascendente",
                sortDescending: ": Activar para ordenar la columna de manera descendente"
            }
        }
    });
}

function custom_select2(){
    $("select").select2({
        dropdownCssClass: 'dropdown-inverse'
    });
}

$(function(){
    form_actions();
    form_list_grid();
    custom_select2();
});