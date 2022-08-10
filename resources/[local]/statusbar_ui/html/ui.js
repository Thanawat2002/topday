$(document).ready(function() {
    window.addEventListener("message", function(event) {
        var data = event.data;

        if (event.data.action == "updateStatus") {
            updateStatus(event.data.st);
        }
		
		if (data.setDisplay) {
			$(".container").css({ "display": data.displayPause });
			$(".container-inner").css({ "display": data.displayDead }, );
            $(".id").show();
            document.getElementById("id").textContent = data.id;
		}
		
		if (data.health > 20) {
			$("#boxHeal").css("height", data.health + "%");
			$("#alertHeal").css("animation", "blinker-stop")
			$("#alertHeal").css("background-color", "transparent")
		} else if (data.health <= 20) {
			$("#boxHeal").css("height", data.health + "%");
			$("#alertHeal").css("animation", "blinker 1s linear infinite")
			$("#alertHeal").css("background-color", "rgb(255, 0, 0, 0.5)")
		}
		
		if (data.armor == 0) {
            $("#armor").hide();
            $(".test3").hide();
		} else if (data.armor > 10) {
            $("#armor").show();
            $(".test3").show();
			$("#boxArmor").css("height", data.armor + "%");
			$("#alertArmor").css("animation", "blinker-stop")
			$("#alertArmor").css("background-color", "transparent")
		} else if (data.armor <= 10) {
			$("#armor").show();
			$(".test3").show();
			$("#boxArmor").css("height", data.armor + "%");
			$("#alertArmor").css("animation", "blinker 1s linear infinite")
			$("#alertArmor").css("background-color", "rgb(255, 0, 0, 0.5)")
		}
		
		if (data.stamina >= 100) {
			$("#stamina").hide();
			$(".test1").hide();
		} else if (data.stamina > 10) {
			$("#stamina").show();
			$(".test1").show();
			$("#boxStamina").css("height", data.stamina + "%");
			$("#alertStamina").css("animation", "blinker-stop")
			$("#alertStamina").css("background-color", "transparent")
		} else if (data.stamina <= 10) {
			$("#stamina").show();
			$(".test1").show();
			$("#boxStamina").css("height", data.stamina + "%");
			$("#alertStamina").css("animation", "blinker 1s linear infinite")
			$("#alertStamina").css("background-color", "rgb(255, 0, 0, 0.5)")
		}
		
		if (data.dive >= 100) {
			$("#dive").hide();
			$(".test2").hide();
		} else if (data.dive > 32) {
			$("#dive").show();
			$(".test2").show();
			$("#boxDive").css("height", data.dive + "%");
			$("#alertDive").css("animation", "blinker-stop")
			$("#alertDive").css("background-color", "transparent")
		} else if (data.dive <= 32) {
			$("#dive").show();
			$(".test2").show();
			$("#boxDive").css("height", data.dive + "%");
			$("#alertDive").css("animation", "blinker 1s linear infinite")
			$("#alertDive").css("background-color", "rgb(255, 0, 0, 0.5)")
		}	
    })
})

function updateStatus(status) {

    for (i = 0; i < status.length; i++) {

        if (status[i].name === 'hunger') {
            if (status[i].val > 100000) {
                $('#boxHunger').css('height', status[i].percent + '%');
                $('#alertHunger').css('animation', 'blinker-stop');
                $('#alertHunger').css('background-color', 'transparent');
            } else {
                $('#boxHunger').css('height', status[i].percent + '%');
                $('#alertHunger').css('animation', 'blinker 1s linear infinite');
                $('#alertHunger').css('background-color', 'rgb(255, 0, 0, 0.5)');
            }
        } else if (status[i].name === 'thirst') {
            if (status[i].val > 100000) {
                $('#boxThirst').css('height', status[i].percent + '%');
                $('#alertThirst').css('animation', 'blinker-stop');
                $('#alertThirst').css('background-color', 'transparent');
            } else {
                $('#boxThirst').css('height', status[i].percent + '%');
                $('#alertThirst').css('animation', 'blinker 1s linear infinite');
                $('#alertThirst').css('background-color', 'rgb(255, 0, 0, 0.5)');
            }
		} else if (status[i].name === 'stress') {
            if (status[i].val > 900000) {
                $('#boxStress').css('height', status[i].percent + '%');
                $('#alertStress').css('animation', 'blinker-stop');
                $('#alertStress').css('background-color', 'transparent');
            } else {
                $('#boxStress').css('height', status[i].percent + '%');
                $('#alertStress').css('animation', 'blinker 1s linear infinite');
                $('#alertStress').css('background-color', 'rgb(255, 0, 0, 0.5)');
            }
        }
    }
}
