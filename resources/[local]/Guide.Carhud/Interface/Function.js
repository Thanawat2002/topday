
function closeMain() {
    $("body").css("display", "none");

}

function openMain() {
    $("body").css("display", "block");

}

window.addEventListener('message', function (event) {

    var item = event.data;

    var hasBelt = event.data.hasBelt,
        beltOn = event.data.beltOn,
        streetName = event.data.streetName

    var bs = document.getElementById("Sound");
    bs.value = 0.8;


    $("#header").css("transform", "scale(" + item.scale + ") ");
    this.document.querySelector('.placeName').innerHTML = '<i class="fas fa-map-marker-alt"></i> ' + streetName;

    if (hasBelt) {
        this.document.getElementById('belt').style.display = ""
    } else {
        this.document.getElementById('belt').style.display = "none"
    }

    if (beltOn && hasBelt) {
        document.getElementById('belt').classList.add('active');
        bs.pause();
    } else if (!beltOn && hasBelt) {
        bs.play();
        document.getElementById('belt').classList.remove('active');
    }

    

    if (item.tyres1 == "1") {
        document.getElementById('tyres1').classList.add('active');
    } else if (item.tyres1 == "0") {
        document.getElementById('tyres1').classList.remove('active');
    }

    if (item.tyres2 == "2") {
        document.getElementById('tyres2').classList.add('active');
    } else if (item.tyres2 == "0") {
        document.getElementById('tyres2').classList.remove('active');
    }

    if (item.tyres3 == "3") {
        document.getElementById('tyres3').classList.add('active');
    } else if (item.tyres3 == "0") {
        document.getElementById('tyres3').classList.remove('active');
    }

    if (item.tyres4 == "4") {
        document.getElementById('tyres4').classList.add('active');
    } else if (item.tyres4 == "0") {
        document.getElementById('tyres4').classList.remove('active');
    }

    if (item.class == "bike") { 
        document.getElementById("tyres1").style.opacity = "1";
        document.getElementById("tyres2").style.opacity = "0.25";
        document.getElementById("tyres3").style.opacity = "1";
        document.getElementById("tyres4").style.opacity = "0.25";
    }else if (item.class == "another") {
        document.getElementById("tyres1").style.opacity = "1";
        document.getElementById("tyres2").style.opacity = "1";
        document.getElementById("tyres3").style.opacity = "1";
        document.getElementById("tyres4").style.opacity = "1";
    } else if (item.class == "Planes") {
        document.getElementById("tyres1").style.opacity = "0.25";
        document.getElementById("tyres2").style.opacity = "0.25";
        document.getElementById("tyres3").style.opacity = "0.25";
        document.getElementById("tyres4").style.opacity = "0.25";
     } else if (item.class == "Boat") {
        document.getElementById("tyres1").style.opacity = "0.25";
        document.getElementById("tyres2").style.opacity = "0.25";
        document.getElementById("tyres3").style.opacity = "0.25";
        document.getElementById("tyres4").style.opacity = "0.25";
     }

    if (item.message == "show") {
        openMain();
        $(".percent-fuel").css("height", (item.fuel) + "%");
        $(".percent-engin").css("height", item.engineHealth   + "%");
        $(".speedprogress").css("width", Math.round(item.speed * 1.5));
        $(".gear").html("<i class='fad fa-steering-wheel '></i> Gear: "+Math.round(item.gear));
        $(".levelengine").html(Math.round(item.engineHealth) + "%");
        $(".levelfuel").html(Math.round(item.fuel) + "%");
        $(".speed").html(Math.round(item.speed) + "<span id='KHM'>KHM</span>");
        $(".name").html("<i class='fad fa-cars '></i> Type : " + item.name);
    }

    if (item.message == "hide") {
        bs.pause();
        closeMain();
    }

    if (event.data.Class == "playSound") {

        audioPlayer = new Audio("./Sound/" + event.data.FileName + ".ogg");
        audioPlayer.volume = event.data.Volume;
        audioPlayer.play();
    }


});