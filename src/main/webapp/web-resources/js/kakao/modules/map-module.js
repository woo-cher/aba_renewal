document.write("<script src='/web-resources/js/page-helper.js'></script>");

class MapModule {
    constructor() {
        this.pageHelper = new PageHelper(5)
    }

    getPolygons(coordinates) {
        const polygons = [];

        let paths = [];

        coordinates.map((coordinate) => {
            if (coordinate[0].length === 2) {
                coordinate.map(async (item) => {
                    await paths.push(new kakao.maps.LatLng(item[1], item[0]))
                })
            } else {
                coordinate[0].map(async (item) => {
                    await paths.push(new kakao.maps.LatLng(item[1], item[0]))
                })
            }

            const polygon = new kakao.maps.Polygon({
                map: this.map,
                path: paths,
                strokeWeight: 3,
                strokeColor: '#fff',
                strokeOpacity: 0.1,
                fillColor: '#cfdbed'
            });

            polygons.push(polygon);

            paths = []
        });

        return polygons
    }

    paint(polygons) {
        if (typeof polygons === 'undefined' || polygons.length === 0) {
            return
        }

        polygons.map((polygon) => {
            polygon.setOptions({
                fillColor: '#00adef',
                strokeColor: '#0088ff',
                strokeOpacity: 0.5,
                fillOpacity: 0.4
            })
        })
    }

    recover(polygons) {
        if (typeof polygons === 'undefined' || polygons.length === 0) {
            return
        }

        polygons.map((polygon) => {
            polygon.setOptions({
                fillColor: '#00ff0000',
                strokeColor: '#00ff0000',
                strokeOpacity: null,
                fillOpacity: null
            })
        })
    }

    clear(overlays) {
        if (overlays.length === 0) {
            return
        }

        for (let index = 0; index < overlays.length; index++) {
            overlays[index].setMap(null)
        }
    }

    /**
     * When specified 'overlay' on `dbclick` event,
     * navigate `map` to level case by weight code.
     *
     * @ex `Si` dbclick -> navigate to 'Gu` level.
     * @link mapWeightType
     *
     * @param weightCode
     * @returns {*}
     */
    getLevelWhenOverlayDoubleClick(weightCode) {
        let level;
        let keys = Object.keys(mapWeightType);

        switch (weightCode) {
            case keys[0]: {
                level = 9;
                break
            }

            case keys[1]: {
                level = 7;
                break
            }

            case keys[2]: {
                level = 3;
                break
            }
        }

        return level
    }

    updateOffersAndPages(page, pageInfo = [], region, isPremium) {
        const offers = pageInfo['size'] !== 0 ? pageInfo['list'] : [];
        this.pageHelper.endPage = pageInfo['pages'];
        this.updateOffers(offers, pageInfo['total'], isPremium);

        if (pageInfo['size'] !== 0) {
            this.bindPagination(pageInfo, $('.offer-list'), region);
        }
    }

    bindPagination(pageInfo, offerArea, region = "") {
        const pageNum = pageInfo['pageNum'];

        if (this.pageHelper.startPage + 5 === pageNum) {
            this.pageHelper.startPage = pageNum;
        }

        if (!offerArea.hasClass("paginator")) {
            offerArea.append(`
                <div class="paginator">
                    <div class="page-wrap">
                        <button class="page prev" onclick="pagingCaller(${this.pageHelper.startPage - 5}, true, '${region}')">
                            <img src="/web-resources/img/basic/keyboard_arrow_left-24px.svg">
                        </button>
                        <ul class="pages" style="display: contents;"></ul>
                        <button class="page prev" onclick="pagingCaller(${this.pageHelper.startPage + 5}, false, '${region}')">
                            <img src="/web-resources/img/basic/keyboard_arrow_right-24px.svg">
                        </button>
                    </div>
                </div>
            `)
        }

        this.pageHelper.pageCalculation(this.pageHelper.startPage, pageInfo, (pageNum) => {
            pagingCaller(pageNum, null, region);
        });
    }

    /**
     * Update `offers`
     * when `zoom_changed`, `dragend`, `overlay click` ...
     *
     * @param offers
     * @param total
     */
    updateOffers(offers, total, isPremium) {
        const offersArea = $('.list-container');
        // console.log(offers);

        offersArea.empty();
        $('.paginator').remove();

        if (total === 0) {
            $('.list-header > strong').text("없음");
            $('.list-container').append(`
                <div class="align-center" style="padding: 40% 0;">
                    <p class="aba txt-lg">이 지역엔 매물이 없어요 :(</p>
                </div>
            `);
        } else {
            $('.list-header > strong').text(`${total}개`);

            for (let i = 0; i < offers.length; i++) {
                let offer = offers[i];
                let endpoint = "https://abasystem.s3.ap-northeast-2.amazonaws.com/offer-images/";

                offersArea.append(`
                    <li class="list-item">
                        <input type="hidden" class="latitude" value="${offer.offerAddress.latitude}">
                        <input type="hidden" class="longitude" value="${offer.offerAddress.longitude}">
                        <div class="offer-like">
                            <img src="/web-resources/img/offer/detail_head_icon-01.png" onclick="alert('준비중이예요 :)')">
                        </div>
                        <div class="offer" onclick="window.open('/offers/${offer.id}')">
                            <div class="offer-thumbs"">
                                <img src="${endpoint + offer.thumbnail}">
                            </div>
                            <p class="offer-summary">
                                매물번호 : ${isPremium ? offer.id : '**'}
                                <label class="r-float">확인일자 ${offer.updatedAt.slice(2, 10)}</label>
                            </p>
                            <p class="offer-deal">
                                <label>${offer.dealType.value}</label>
                                <strong>
                                    ${offer.dealType.code === "SALE" ? offer.salePrice/10000 + "억" : offer.deposit + "/" + offer.monthlyPrice}
                                    <span class="aba">
                                        ${offer.dealType.code === "SALE" ? "" :
                                        offer.managementPrice !== null ? 
                                        " + " + offer.managementPrice : ""}
                                    </span>
                                </strong>
                            </p>
                            <p class="offer-addr">
                                ${isPremium ? offer.offerAddress.jibun != null ? offer.offerAddress.jibun : '(건물명 없음)' : offer.offerAddress.belongsTo + ' ***-**'}
                            </p>
                            <p class="offer-building">
                                ${isPremium ? offer.offerAddress.buildingName !== null ? offer.offerAddress.buildingName : '' : ''}
                            </p>
                            <div class="offer-summary">
                                <strong>
                                    ${offer.type.value} |
                                    ${isPremium ?
                                      offer.offerAddress.floor === '-1' ? offer.offerAddress.ho :
                                      offer.offerAddress.floor === '100' ? offer.offerAddress.ho : 
                                      offer.offerAddress.ho === null ? '?호' :
                                      offer.offerAddress.ho : '*** 호'
                                    }
                                     | ${offer.heatingType !== null ? offer.heatingType.value : ""}
                                </strong>
                            </div>
                            <div class="label-info">
                                <label>세입자: ${offer.offerAddition.tenant == null ? "정보없음" : offer.offerAddition.tenant}</label>
                                ${offer.offerAddition.parking ? '<label>주차가능</label>' : ''}
                                <label>호실번호 : ${offer.offerAddress.door == null ? "정보없음" : offer.offerAddress.door}</label>
                            </div>
                            <p class="offer-tel">
                                <i class="fas fa-phone-square-alt"></i>
                                &nbsp;${isPremium ? offer.inquiryTel : '***-****-****'}
                            </p>
                        </div>
                    </li>
                `)
            }
        }

        // If spot level, add marker event of hover
        if (this.level < 4) {
            $(".list-item").hover(function (e) {
                let element = $(e.currentTarget);
                let latitude = parseFloat(element.find('.latitude').val());
                let longitude = parseFloat(element.find('.longitude').val());

                var imageSrc = '/web-resources/img/offer/detail_map_icon.png',
                    imageSize = new kakao.maps.Size(25, 35),
                    imageOption = {offset: new kakao.maps.Point(13, 45)};

                var marker = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(latitude, longitude),
                    image: new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
                });

                marker.setMap(mapManager.map);
                mapManager.setCenter(latitude, longitude);
            }, function() {
                $("img[src='/web-resources/img/offer/detail_map_icon.png'").remove();
            });
        }
    }

    getLevelByWeight(weight) {
        switch (weight) {
            case 1: {
                return 12;
                break
            }
            case 2: {
                return 9;
                break
            }
            case 3: {
                return 7;
                break
            }
            case 4: {
                return 3;
                break;
            }
        }
    }

    addClassElement(target, clazz) {
        target.classList.add(clazz)
    }

    removeClassElement(target, clazz) {
        target.classList.remove(clazz)
    }

    isContainClass(target, clazz) {
        return target.classList.contains(clazz)
    }
}

function loadMapWithMarker(mapElementId, latitude, longitude, isOfferDetail) {
    $('#' + mapElementId).show();
    var map;

    if (isOfferDetail) {
        map = new kakao.maps.Map(document.getElementById(mapElementId), {
            center: new kakao.maps.LatLng(latitude, longitude),
            level: 3,
            minLevel: 2,
            maxLevel: 10
        });
    } else {
        map = this.map;
    }

    var imageSrc = '/web-resources/img/offer/detail_map_icon.png',
        imageSize = new kakao.maps.Size(25, 35),
        imageOption = {offset: new kakao.maps.Point(20, 35)}; // ??

    var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(latitude, longitude),
        image: new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
    });

    marker.setMap(map);
}
