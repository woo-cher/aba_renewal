/* ─────────────────────────── MAP ────────────────────────────── */

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

function getOffersOfMap(southWest, northEast, region = null, page = 1) {
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
        url: '/apis/maps/offers',
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
        url: '/apis/maps/offers/spot',
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
        url: '/apis/maps/offers?idKey=' + idKey,
        type: 'GET',
        async: false,
        success: function (offers) {
            result = offers;
        },
        error: ajaxError
    });

    return result;
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

/* ─────────────────────────── /MAP ────────────────────────────── */

/* ─────────────────────────── OFFER ───────────────────────────── */

function getOffers(page = null, userId = null) {
    let result;
    let url;

    if (userId !== null && page === null) {
        url = '/apis/offers?user=' + userId;
        console.log('1 : 유저가 가진 논페이징 매물들')
    } else if (userId === null) {
        url = '/apis/offers?page=' + page;
        console.log('2 : 모든 매물 페이징')
    } else {
        url = '/apis/offers?user=' + userId + '&page=' + page;
        console.log('3 : 유저가 가진 페이징 매물')
    }

    $.ajax({
        url: url,
        type: 'GET',
        async: false,
        success: function (offers) {
            result = offers;
        },
        error: ajaxError
    });

    return result;
}

function deleteOfferById(offerId) {
    let result;

    $.ajax({
        url: '/apis/offers/' + offerId,
        type: 'DELETE',
        async: false,
        success: function (deleteRow) {
            result = deleteRow;
        },
        error: ajaxError
    });

    return result;
}

function deleteImage(offerId, target) {
    $.ajax({
        url: '/apis/s3/delete?offerId=' + offerId + '&fileName=' + target,
        type: 'DELETE',
        async: false,
        contentType: 'application/json',
        success: function () {
            console.log("delete : ", target);
        },
        error: ajaxError
    });
}

function searchOffer(keyword, page) {
    let result;

    $.ajax({
        url: '/apis/offers/search?keyword=' + keyword + '&page=' + page,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (requests) {
            result = requests;
        },
        error: ajaxError
    });

    return result;
}

function getOffersByFilter(page = null) {
    let result;
    let requestBody = {};

    if (page !== null) {
        requestBody['page'] = Number(page);
    }

    $.ajax({
        url: '/apis/offers/filter',
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

/* ────────────────────────── /OFFER ───────────────────────────── */

/* ──────────────────────────── USER ───────────────────────────── */

function getAllUsers(page) {
    let result;

    $.ajax({
        url: '/apis/users/all/' + page,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (requests) {
            result = requests;
        },
        error: ajaxError
    });

    return result;
}

function getUsersExceptAdmin(page) {
    let result;

    $.ajax({
        url: '/apis/users/general/' + page,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (requests) {
            result = requests;
        },
        error: ajaxError
    });

    return result;
}

function deleteUserById(userId) {
    let result;

    $.ajax({
        url: '/apis/users/' + userId,
        type: 'DELETE',
        async: false,
        success: function (deleteRow) {
            result = deleteRow;
        },
        error: ajaxError
    });

    return result;
}

function searchUser(keyword, page) {
    let result;

    $.ajax({
        url: '/apis/users/search?keyword=' + keyword + '&page=' + page,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (requests) {
            result = requests;
        },
        error: ajaxError
    });

    return result;
}

function isValidPassword(inputPassword) {
    let result;

    $.ajax({
        url: '/apis/users/password/certify',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        datatype: 'text',
        data: inputPassword,
        success: function (certifiedResult) {
            result = certifiedResult;
        },
        error: ajaxError
    });

    return result;
}

/* ─────────────────────────── /USER ───────────────────────────── */

/* ─────────────────────────── COMMON ──────────────────────────── */
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
    alert("서버와의 데이터 수신에 실패했습니다 :(");
}
/* ─────────────────────────── /COMMON ──────────────────────────── */

/* ─────────────────────────── REQUEST ──────────────────────────── */
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
/* ────────────────────────── /REQUEST ──────────────────────────── */

/* ──────────────────────────── POST ────────────────────────────── */
function getPosts(page) {
    let result;

    $.ajax({
        url: '/apis/posts/all?page=' + page,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (requests) {
            result = requests;
        },
        error: ajaxError
    });

    return result;
}

function deletePost(id) {
    let result;

    $.ajax({
        url: '/apis/posts/' + id,
        type: 'DELETE',
        async: false,
        contentType: 'application/json',
        success: function (requests) {
            console.log("post deleted")
        },
        error: ajaxError
    });

    return result;
}
/* ──────────────────────────── /POST ───────────────────────────── */
