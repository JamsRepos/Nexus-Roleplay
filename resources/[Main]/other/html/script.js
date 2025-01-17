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
	
    $("#register").submit(function(e) {
        e.preventDefault();
        
        $.post('http://other/register', JSON.stringify({
            message: $("#message").val()
        }));
    }); 
});
 
$(function() {
    $('#exitbank').click(function(){
        $.post('http://other/close', JSON.stringify({}));
    })
});
 
$(function() {
    $(document).keyup(function(e) {
        if(e.keyCode == 27){
            $.post('http://other/close', JSON.stringify({}));
        }
    })
});
 
$(function() {
    $(document).keyup(function(e) {
        if(e.keyCode == 13){
            $("#register").submit(function(e) {
                e.preventDefault();
                
                $.post('http://other/register', JSON.stringify({
                    message: $("#message").val()
                }));
            }); 
        }
    })
});