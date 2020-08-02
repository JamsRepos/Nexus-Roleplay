$(function(){
	window.onload = (e) => {
        /* 'links' the js with the Nui message from main.lua */
		window.addEventListener('message', (event) => {
            //document.querySelector("#logo").innerHTML = " "
			var item = event.data;
			if (item !== undefined && item.type === "gopro") {
                /* if the display is true, it will show */
				if (item.display === true) {
                    $('.container').fadeIn();
                     /* if the display is false, it will hide */
				} else{
                    $('.container').fadeOut();
                }
			}
			if (item !== undefined && item.type === "blindfold") {
                /* if the display is true, it will show */
				if (item.display === true) {
                    $('.container2').fadeIn();
                     /* if the display is false, it will hide */
				} else{
                    $('.container2').fadeOut();
                }
			}
		});
	};
});

