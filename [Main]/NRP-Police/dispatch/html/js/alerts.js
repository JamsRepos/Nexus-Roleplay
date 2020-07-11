$('document').ready(function() {
    alerts = {};
    

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item !== undefined && item.type === "alerts") {
            ShowNotif(item);
        }
    });

    function ShowNotif(data) {
            var $notification = CreateNotification(data);
            $('.notif-container').append($notification);
            setTimeout(function() {
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove()
                });
            }, data.length != null ? data.length : 7500);
    }

    function CreateNotification(data) {
       var $notification = $(document.createElement('div'));
       if (data.info.isImportant === 1) {
            $notification.addClass('notification').addClass('officer-down');
       } else {
            $notification.addClass('notification').addClass(data.job);
       }
       var extra = "";
       if (data.info.extra != null) {
        var array = JSON.parse(data.info.extra);
        if (array[0].cartheftModel != null) {
            extra = '\
            <i class="fa fa-car"></i>' + array[0].cartheftModel + ' <i class="fa fa-cc"></i>' + array[0].cartheftPlate + '\
            <br><i class="fas fa-palette"></i>' + array[0].cartheftColour.primary + ' on ' + array[0].cartheftColour.secondary + '\
            <br><i class="fa fa-user"></i>' + array[0].cartheftSex + '\
            <br>';
        } else if (array[0].gunshotSex != null) {
            extra = '\
            <i class="fa fa-user"></i>' + array[0].gunshotSex + '\
            <br>';
        } else if (array[0].drugsaleSex != null) {
            extra = '\
            <i class="fa fa-user"></i>' + array[0].drugsaleSex + '\
            <br>';
        } else if (array[0].civrobSex != null) {
            extra = '\
            <i class="fa fa-user"></i>' + array[0].civrobSex + '\
            <br>';
        } else if (array[0].robberyMessage != null) {
            extra = '\
            <i class="fas fa-eye"></i>' + array[0].robberyMessage + '\
            <br>';
        }
       }
       $notification.html('\
       <div class="content">\
       <div id="code">' + data.info.dispatchCode + '</div>\
       <div id="alert-name">' + data.info.dispatchMessage + '</div>\
       <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
       <div id="alert-info">\
       ' + extra + '\
       <i class="fas fa-globe-europe"></i>' + data.info.street + '\
       </div>\
       </div>');
       $notification.fadeIn();
       if (data.style !== undefined) {
           Object.keys(data.style).forEach(function(css) {
               $notification.css(css, data.style[css])
           });
       }
       return $notification;
    }
});

//       <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\