function form_actions(){
    $(".fa-navicon").click(function() {
        $(".form-actions").toggle();
    });
}

function form_list_grid(){
    $('.datatable').DataTable({
        "dom": 'Rlfrtip',
        "responsive": true
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
