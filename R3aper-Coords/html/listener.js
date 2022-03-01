var visable = false;

$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			case 'toggle':
				if (visable) {
					$('#wrap').fadeOut();
				} else {
					$('#wrap').fadeIn();
				}

				visable = !visable;
				break;

			case 'close':
				$('#wrap').fadeOut();
				visable = false;
				break;

			case 'updateCoords':
				document.getElementById("coord1").value = "x = " + event.data.x + ", y = " + event.data.y + ", z = " + event.data.z

				document.getElementById("coord2").value = "vector3(" + event.data.x + ", " + event.data.y + ", " + event.data.z + ")"

				document.getElementById("coord3").value = "heading = " + event.data.h

				break;

			default:
				console.log('BRUH');
				break;
		}
	}, false);

	document.onkeyup = function (data) {
		if (data.which == 27) {
			$.post("http://R3aper-Coords/close", JSON.stringify({}))
		}
	}
});