$(function() {
    window.addEventListener("message", function(event) {
        var item = event.data;
        var audioPlayer = null;
        if (item !== undefined) {
            if (item.type == "ui") {
                if (item.display == true) {
                    $('.container').show();

                } else {
                    $('.container').hide();

                }
            } else if (item.type == "update") {
                $("#my_id").html(item.my_id);
                $("#my_phonenumber").html(item.my_phonenmumber);
                $("#my_fullname").html(item.my_fullname);
                $("#my_job").html(item.my_job);
                $("#my_ping").html(item.my_ping + "ms");
                $("#players").html(item.players + '/500');
                $("#police").html(item.police);
                $("#ems").html(item.ems);
                $("#mc").html(item.mc);
                $("#chef").html(item.chef);
            }
        }
        // console.log(item.my_id)
    });

    var x = document.getElementById("myAudio");

    function playAudio() {
        x.play();
    }

    function pauseAudio() {
        x.load();
    }

});