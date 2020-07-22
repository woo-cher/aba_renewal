class PolygonModule {
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
