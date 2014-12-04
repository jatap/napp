$(document).ready(function() {

    error_flash_messages();

});

/**
 * Functions
 */

// Decorate Devise all error messages except login one
function error_flash_messages()
{
    // Vars (clean code)
    var element = $(".error_notification");
    var textElement = element.text();

    // New HTML template
    var newHtml = ""
    + "<div class='alert alert-danger alert-dismissable' role='alert'>"
    + "<button type='button' class='close' data-dismiss='alert'>"
    + "<span aria-hidden='true'>&times;</span>"
    + "<span class='sr-only'>Close</span>"
    + "</button>"
    + "<div id='flash_danger'>" + textElement + "</div>"
    + "</div";

    // Set new decorated HTML
    $(".error_notification").replaceWith(newHtml);
}
