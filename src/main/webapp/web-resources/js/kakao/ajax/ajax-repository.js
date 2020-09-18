function getAllOverlays(weight, southWest, northEast) {
    let result;
    let requestBody = {
        weight: weight,
        south: southWest.Ga,
        west: southWest.Ha,
        north: northEast.Ga,
        east: northEast.Ha
    };

    $.ajax({
        url: '/apis/overlays',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: addFiltersOfReqBody(requestBody),
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
            belongsTo: region,
        }
    } else {
        requestBody = {
            page: page,
            south: southWest.Ga,
            west: southWest.Ha,
            north: northEast.Ga,
            east: northEast.Ha,
        }
    }

    $.ajax({
        url: '/apis/offers',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: addFiltersOfReqBody(requestBody),
        success: function (pageInfo) {
            result = pageInfo;
        },
        error: ajaxError
    });

    return result;
}

function getOffersByLatLng(latitude, longitude) {
    let result;
    let requestBody = {
        latitude: latitude,
        longitude: longitude
    };

    $.ajax({
        url: '/apis/offers/spot',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: addFiltersOfReqBody(requestBody),
        success: function (offers) {
            result = offers;
        },
        error: ajaxError
    });

    return result;
}

function getOverlaysByKeyword(keyword) {
    let result;

    $.ajax({
        url: '/apis/overlays?keyword=' + keyword,
        type: 'GET',
        async: false,
        success: function (overlays) {
            result = overlays;
        },
        error: ajaxError
    });

    return result;
}

function getOffersByIdKeyword(idKey) {
    let result;

    $.ajax({
        url: '/apis/offers?idKey=' + idKey,
        type: 'GET',
        async: false,
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

function addFiltersOfReqBody(reqBody) {
    reqBody['offerTypes'] = filtersDto.offerType;
    reqBody['dealTypes'] = filtersDto.dealType;
    reqBody['maxDeposit'] = filtersDto.deposit;
    reqBody['maxMonthlyPrice'] = filtersDto.monthlyPrice;
    reqBody['isParking'] = filtersDto.isParking;
    reqBody['isNotTenant'] = filtersDto.isNotTenant;
    reqBody['isPet'] = filtersDto.isPet;
    reqBody['hasElevator'] = filtersDto.hasElevator;
    reqBody['isCanTerm'] = filtersDto.isCanTerm;
    reqBody['floor'] = filtersDto.floor;
    reqBody['completionYear'] = filtersDto.year;
    reqBody['options'] = filtersDto.option;

    return JSON.stringify(reqBody);
}

function getRequests(requestFilterDto) {
    let result;

    $.ajax({
        url: '/requests/filters',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: JSON.stringify(requestFilterDto),
        success: function (requests) {
            result = requests;
        },
        error: ajaxError
    });

    return result;
}
