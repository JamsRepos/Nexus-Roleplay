window.addEventListener('message', function (event) {


    switch (event.data.action) {
        case 'tick':
            $(".container").css("display", event.data.show ? "none" : "block");
            $("#boxHeal").css("width", event.data.health + "%");
            $("#boxArmor").css("width", event.data.armor + "%");
            //$("#boxStamina").css("width", event.data.stamina + "%");
            widthHeightSplit($("#boxStamina").height(), event.data.stamina, $("#boxStamina"));

        case 'updateStatus':
            //$('#boxHunger').css('width', event.data.hunger + '%');
            widthHeightSplit($("#hunger").height(), event.data.hunger, $("#boxHunger"));
            //$('#boxThirst').css('width', event.data.thirst + '%');
            widthHeightSplit($("#thirst").height(), event.data.thirst, $("#boxThirst"));
            //$('#boxStress').css('width', event.data.stress + '%');
            widthHeightSplit($("#stress").height(), event.data.stress, $("#boxStress"));
            break;
        case 'showui':
            $('body').fadeIn();
            break;
        case 'hideui':
            $('body').fadeOut();
            break;
        case 'set-voice':
            $("#boxVoice").css("width", event.data.value + "%");
            break;
        case 'vehicle-hud-on':
            $('.street').fadeIn();
            break;
        case 'vehicle-hud-update':
            $(".street-txt").empty();
            $(".street-txt").append(event.data.street);
            $(".direction").find(".image").attr('style', 'transform: translate3d(' + event.data.direction + 'px, 0px, 0px)');
            break;
        case 'vehicle-hud-off':
            $('.street').fadeOut();
            break;
        case 'voice-color':
            if (event.data.isTalking) {
                $("#boxVoiceOn").css("width", "100%");
                $('#boxVoice').addClass('active');
                $("#boxVoice2On").css("width", "100%");
                $('#boxVoice2').addClass('active');
                $("#boxVoice3On").css("width", "100%");
                $('#boxVoice3').addClass('active');
            } else {
                $("#boxVoiceOn").css("width", "0%");
                $('#boxVoice').removeClass('active');
                $("#boxVoice2On").css("width", "0%");
                $('#boxVoice2').removeClass('active');
                $("#boxVoice3On").css("width", "0%");
                $('#boxVoice3').removeClass('active');
            }
            break;
    }
});

function formatCurrency(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function widthHeightSplit(orig, value, ele) {
    let height = orig;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("left", leftOverHeight + "px");
};