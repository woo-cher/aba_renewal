function getAllOverlays(weight, southWest, northEast) {
    let result;

    $.ajax({
        url: '/overlays',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: JSON.stringify({
            weight: weight,
            south: southWest.Ga,
            west: southWest.Ha,
            north: northEast.Ga,
            east: northEast.Ha
        }),
        success: function (overlays) {
            result = overlays;
        },
        error:ajaxError
    });

    return result;
}

function getCoordinates(id) {
    let result;

    $.ajax({
        url: '/overlays/' + id,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (overlays) {
            result = overlays;
        },
        error:ajaxError
    });

    // string to json
    return JSON.parse(result.coordinates);
}

function ajaxError() {
    alert("Error !");
}
