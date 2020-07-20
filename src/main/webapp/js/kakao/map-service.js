class kakaoMap {
    constructor(element) {
        if (element === null) {
            throw new Error("Map Constructor argument is null")
        }

        this.map = new kakao.maps.Map(element, {
            center: new kakao.maps.LatLng(37.4969117, 127.03292),
            level: 7
        });

        this.setMaxLevel(12);
        this.setMinLevel(1);
        this.setZoomControl(this.getZoomControl())
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

    getPolygons(overlay) {
        const coordinates = JSON.parse(overlay.coordinate); // json to array
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

    getNorthEast() {
        this.undefinedChecker();
        return this.bounds.getNorthEast()
    }

    getSouthWest() {
        this.undefinedChecker();
        return this.bounds.getSouthWest()
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

    convertToLatlng(x, y) {
        return new kakao.maps.LatLng(x, y)
    }

    eventTrigger() {
        kakao.maps.event.trigger(this.map, 'dragend')
    }

    kakaoEventListener(evt, callback) {
        kakao.maps.event.addListener(this.map, evt, () => {
            callback()
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
            navigator.geolocation.getCurrentPosition(function(pos) {
                return new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude)
            })
        }
    }
}
