$(function(){
	window.onload = (e) => {
        /* 'links' the js with the Nui message from main.lua */
		window.addEventListener('message', (event) => {
            //document.querySelector("#logo").innerHTML = " "
			var item = event.data;
			if (item !== undefined && item.type === "dispatch") {
                /* if the display is true, it will show */
				if (item.display === true) {
					$('body').show();
					var table = item.onduty;
					if (table != null) {
						var string = table.toString();
						var onduty = string.replace(/,/g, '<br>');
						document.getElementById('duty-list').innerHTML = "<h2>Dispatch</h2>" + onduty;
					}            
				} else{
                    $('body').hide();
                }
			}
		});
	};
});