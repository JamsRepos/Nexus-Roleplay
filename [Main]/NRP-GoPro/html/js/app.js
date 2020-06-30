$(function(){
	window.onload = (e) => {
        /* 'links' the js with the Nui message from main.lua */
		window.addEventListener('message', (event) => {
            //document.querySelector("#logo").innerHTML = " "
			var item = event.data;
			if (item !== undefined && item.type === "ui") {
                /* if the display is true, it will show */
				if (item.display === true) {
                    $('body').fadeIn();
                     /* if the display is false, it will hide */
				} else{
                    $('body').fadeOut();
                }
			}
		});
	};
});

