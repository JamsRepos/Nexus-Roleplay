var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

function UpdateCursorPos() {
    cursor.style.left = cursorX;
    cursor.style.top = cursorY;
}

function Click(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
}

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            cursor.style.display = event.data.enable ? "block" : "none";
            document.body.style.display = event.data.enable ? "block" : "none";
            if (event.data.enable) {
             $("#characters").html(event.data.characters);
             $(".dialog").css("display", "block");
            } else {
             $(".dialog").css("display", "none");
            }   
        } else if (event.data.type == "click") {
            // Avoid clicking the cursor itself, click 1px to the top/left;
            Click(cursorX - 1, cursorY - 1);
        }
    });

    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });

    // Register Character Form
    $("#register").submit(function(e) {
        e.preventDefault();
        $(".dialog").css("display", "none");
        $(".register").css("display", "none");
        $.post('http://core/create', JSON.stringify({
            firstname: $("#firstname").val(),
            lastname: $("#lastname").val(),
            dob: $("#dob").val(),
            gender: $('#gender').val(),
        }));
    });
});