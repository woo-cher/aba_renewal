function getAllOverlays(weight, southWest, northEast) {
    let result;

    console.log(southWest, northEast);

    $.ajax({
        url: '/overlays',
        type: 'POST',
        async: false,
        data: {
            weight: weight,
            south: southWest.Ga,
            west: southWest.Ha,
            north: northEast.Ga,
            east: northEast.Ha,
        },
        success: function (overlays) {
            result = overlays;
        },
        error:ajaxError
    });

    return result;
}

function ajaxError() {
    alert("Error !");
}
