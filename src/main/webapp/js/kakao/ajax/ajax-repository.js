function getAllOverlays(weight, southWest, northEast) {
    let result;

    $.ajax({
        url: '/apis/overlays',
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
        url: '/apis/overlays/' + id,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (overlays) {
            result = overlays;
        },
        error:ajaxError
    });

    return JSON.parse(result.coordinates);
}

function searchKakaoAddress(keyword) {
    let result;

    $.ajax({
        url: '/apis/kakao/address?keyword=' + keyword,
        type: 'GET',
        async: false,
        success: function (resultEntity) {
            result = JSON.parse(resultEntity)
        }
    });

    return result;
}

function ajaxError() {
    alert("Error !");
}
