/**
 * Functions
 */

// Decorate  all messages except login one
function frontend_flash_messages()
{
    // Vars (clean code)
    var elements = [ "alert", "error", "notice", "success" ];

    // Toggle visibility
    $.each(elements, function(index, value) {
      var element = ".flash-" + value;
      $(element).click(function (e) {
        e.preventDefault;
        $(this).fadeToggle('slow');
      });
    });
}

// Decorate Devise all error messages (only except login one)
function frontend_sign_in_flash_messages()
{
    // Vars (clean code)
    var element = $(".error_notification");
    var textElement = element.text();

    // Validate proccess
    if (textElement) {

      // New HTML template
      var newHtml = "<div class='flash-error'>" + textElement + "</div>";

      // Put flash message ahter main header
      var header = $("header.navigation");
      header.after(newHtml);

      // Remove original message
      element.remove();
    }
}

/**
 * Loader
 */
$(function(){

    frontend_sign_in_flash_messages();
    frontend_flash_messages();

});
