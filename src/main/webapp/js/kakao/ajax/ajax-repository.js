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

function getOffersByRegion(region) {
    let result;

    $.ajax({
        url: '/apis/offers',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: JSON.stringify({
            belongsTo: region
        }),
        success: function (offers) {
            result = offers;
        },
        error: ajaxError
    });

    return result;
}

function updateOffers(southWest, northEast, region = null) {
    let requestBody;

    if (region !== null) {
        requestBody = {
            belongsTo: region
        }
    } else {
        requestBody = {
            south: southWest.Ga,
            west: southWest.Ha,
            north: northEast.Ga,
            east: northEast.Ha
        }
    }

    requestBody = JSON.stringify(requestBody);

    $.ajax({
        url: '/apis/offers',
        type: 'POST',
        async: false,
        contentType: 'application/json',
        data: requestBody,
        success: function (offers) {
            console.log(offers);
            const offersArea = $('.list-container');

            offersArea.empty();
            $('.paginator').remove();

            if (offers.length === 0) {
                $('.list-header > strong').text(`없음`)
            } else {
                $('.list-header > strong').text(`${offers.length}개`);
                for (let i = 0; i < offers.length; i++) {
                    let offer = offers[i];

                    offersArea.append(`
                        <li class="list-item">
                            <div class="offer-like">
                                <img src="/img/offer/detail_head_icon-01.png" onclick="alert('준비중이예요 :)')">
                            </div>
                            <div class="offer" onclick="window.open('/offers/${offer.id}')">
                                <div class="offer-thumbs">
                                    <img src="/img/offer/detail_slide01.jpg">
                                </div>
                                <p class="offer-deal">
                                    <label>${offer.dealType.value}</label>
                                    <strong>${offer.deposit}/${offer.monthlyPrice} +${offer.managementPrice}</strong>
                                    <label class="r-float">확인일자 ${offer.updatedAt.slice(2,10)}</label>
                                </p>
                                <p class="offer-addr">${offer.offerAddress.jibun}</p>
                                <p class="offer-building">화이트원룸</p>
                                <div class="offer-summary">
                                    <strong>${offer.type.value} | ${offer.offerAddress.ho}호 | ${offer.heatingType.value}</strong>
                                </div>
                                <div class="label-info">
                                    <label>세입자: ${offer.offerAddition.tenant}</label>
                                    ${offer.offerAddition.parking ? '<label>주차가능</label>' : ''}
                                    <label>${offer.offerAddress.door}</label>
                                </div>
                                <p class="offer-tel">
                                    <i class="fas fa-phone-square-alt"></i>
                                    &nbsp;${offer.dealer.agentPhone}
                                </p>
                            </div>
                        </li>
                    `)
                }

                if(!offersArea.parent().hasClass("paginator")) {
                    offersArea.parent().append(`
                            <div class="paginator">
                                <div class="page-wrap">
                                    <button class="page prev">
                                        <img src="/img/basic/keyboard_arrow_left-24px.svg">
                                    </button>
                                    <ul style="display: contents;">
                                        <li class="active"><h6>1</h6></li>
                                        <li><h5>2</h5></li>
                                        <li><h5>3</h5></li>
                                        <li><h5>4</h5></li>
                                        <li><h5>5</h5></li>
                                    </ul>
                                    <button class="page prev">
                                        <img src="/img/basic/keyboard_arrow_right-24px.svg">
                                    </button>
                                </div>
                            </div>
                    `)
                }
            }
        },
        error: ajaxError
    });
}

function ajaxError() {
    alert("Error !");
}
