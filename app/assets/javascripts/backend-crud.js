function form_actions(){
    $(".fa-navicon").click(function() {
        $(".form-actions").toggle();
    });
}

$(function(){
    form_actions();
})
