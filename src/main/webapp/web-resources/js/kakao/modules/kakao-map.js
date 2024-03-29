document.write("<script src='/web-resources/js/kakao/modules/kakao.js'></script>");

const mapWeightType = { Si: 1, Gu: 2, Dong: 3, Spot: 4 };

class KakaoMap extends MapModule {
    mapOptions = {
        center: this.getKakaoLatlng(35.163975, 128.11347),
        level: 12
    };

    constructor(element) {
        super();

        if (element === null) {
            throw new Error("Map Constructor argument is null")
        }

        this.map = new kakao.maps.Map(element, this.mapOptions);

        this.setMaxLevel(12);
        this.setMinLevel(1);
        this.setZoomControl(this.getZoomControl());

        this.bounds = this.getBoundElement();
        this.isPremium = true;
    }

    getKakaoMap() {
        this.undefinedChecker();
        return this.map
    }

    getCustomOverlay(overlayOptions) {
        this.undefinedChecker();
        return new kakao.maps.CustomOverlay(overlayOptions)
    }

    getZoomControl() {
        this.undefinedChecker();
        return new kakao.maps.ZoomControl()
    }

    getClusterer(clustererOptions) {
        this.undefinedChecker();
        return new kakao.maps.MarkerClusterer(clustererOptions)
    }

    getBoundElement() {
        this.undefinedChecker();
        this.bounds = this.map.getBounds();
        return this.bounds
    }

    getMapLevel() {
        this.undefinedChecker();
        return this.map.getLevel()
    }

    getNorthEast() {
        this.undefinedChecker();
        return this.bounds.getNorthEast()
    }

    getSouthWest() {
        this.undefinedChecker();
        return this.bounds.getSouthWest()
    }

    getIsPremium() {
        return this.isPremium;
    }

    setIsPremium(isPremium) {
        this.isPremium = isPremium;
    }

    setCenter(latitude, longitude) {
        this.undefinedChecker();
        this.map.setCenter(new kakao.maps.LatLng(latitude, longitude))
    }

    setLevel(level, mapOptions) {
        this.undefinedChecker();
        return this.map.setLevel(level, mapOptions)
    }

    setMaxLevel(level) {
        this.undefinedChecker();
        this.map.setMaxLevel(level)
    }

    setMinLevel(level) {
        this.undefinedChecker();
        this.map.setMinLevel(level)
    }

    setZoomControl(zoomControl) {
        this.undefinedChecker();
        this.map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT) // fix
    }

    relayout() {
        this.undefinedChecker();
        this.map.relayout()
    }

    getKakaoLatlng(x, y) {
        return new kakao.maps.LatLng(x, y)
    }

    eventTrigger() {
        kakao.maps.event.trigger(this.map, 'dragend');
        this.relayout()
    }

    kakaoEventListener(evt, callback) {
        kakao.maps.event.addListener(this.map, evt, () => {
            callback();
        })
    }

    undefinedChecker() {
        if (this.map === undefined) {
            throw DOMException('Map object is undefined. Please initializing using constructor(element, options)')
        }
    }

    gps() {
        if (navigator.geolocation) {
            console.log('gps init');
            navigator.geolocation.getCurrentPosition((pos) => {
                mapManager.setCenter(pos.coords.latitude, pos.coords.longitude);
                this.eventTrigger();
            });
        } else {
            console.log('navigator initialize error :(');
        }
    }
}
