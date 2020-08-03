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
            east: northEast.Ha,
            offerTypes: filtersDto.offerType,
            dealTypes: filtersDto.dealType,
            maxDeposit: filtersDto.deposit,
            maxMonthlyPrice: filtersDto.monthlyPrice
        }),
        success: function (overlays) {
            result = overlays;
        },
        error: ajaxError
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
        error: ajaxError
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

function getOffersPageInfo(southWest, northEast, region = null, page = 1) {
    let requestBody;
    let result;

    if (region !== null) {
        requestBody = {
            page: page,
            belongsTo: region
        }
    } else {
        requestBody = {
            page: page,
            south: southWest.Ga,
            west: southWest.Ha,
            north: northEast.Ga,
            east: northEast.Ha,
            offerTypes: filtersDto.offerType,
            dealTypes: filtersDto.dealType,
            maxDeposit: filtersDto.deposit,
            maxMonthlyPrice: filtersDto.monthlyPrice
        }
    }

    requestBody = JSON.stringify(requestBody);

    $.ajax({
        url: '/apis/offers',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: requestBody,
        success: function (pageInfo) {
            result = pageInfo;
        },
        error: ajaxError
    });

    return result;
}

function getOffersByLatLng(latitude, longitude) {
    let result;

    $.ajax({
        url: '/apis/offers/spot',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: JSON.stringify({
            latitude: latitude,
            longitude: longitude,
            offerTypes: filtersDto.offerType,
            dealTypes: filtersDto.dealType,
            maxDeposit: filtersDto.deposit,
            maxMonthlyPrice: filtersDto.monthlyPrice
        }),
        success: function (offers) {
            result = offers;
        },
        error: ajaxError
    });

    return result;
}

function ajaxError() {
    alert("Error !");
}
