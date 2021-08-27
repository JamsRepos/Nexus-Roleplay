$(function(){
    window.addEventListener("message", function(event){   
        if (event.data.type == "showNotification") {
       	 $("#notification").html(event.data.message);
       	 $("#phone-notification").css("display", "block");
         $("#phone-notification").show().delay(8000).fadeOut();
        }

        if(event.data.options){
          var options = event.data.options;
          new Noty(options).show();
        }else{
          var maxNotifications = event.data.maxNotifications;
          Noty.setMaxVisible(maxNotifications.max, maxNotifications.queue);
        };
    });
});