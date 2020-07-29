class MapModule {
    constructor() {
        return
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
                level = 4;
                break
            }
        }

        return level
    }

    /**
     * Update `offers`
     * when `zoom_changed`, `dragend`, `overlay click` ...
     *
     * @param offers
     */
    updateOffers(offers) {
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
