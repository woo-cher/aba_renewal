class PolygonModule {
    constructor() {
        return
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

    paint(polygons) {
        if (typeof polygons === 'undefined' || polygons.length === 0) {
            return
        }

        polygons.map((polygon) => {
            polygon.setOptions({
                fillColor: '#8353a9',
                strokeColor: '#7300a9',
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

    /* @Todo Enum 이슈 */
    getZoomLevelByTypeAndCode(typeOrCode) {
        let level;

        switch (typeOrCode) {
            case mapWeightType.Si: {
                level = 9;
                break
            }

            case mapWeightType.Gu: {
                level = 7;
                break
            }

            case mapWeightType.Dong: {
                level = 4;
                break
            }

            case 1: {
                level = 12;
                break
            }
            case 2: {
                level = 9;
                break
            }
            case 3: {
                level = 7;
                break
            }
        }

        return level
    }

     addClassElement(target) {
        target.classList.add(clazz)
    }

     removeClassElement(target, clazz) {
        target.classList.remove(clazz)
    }

     isContainClass(target, clazz) {
        return target.classList.contains(clazz)
    }

}
/*
function getPolygons(overlay) {
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

function paint(polygons) {
    if (typeof polygons === 'undefined' || polygons.length === 0) {
        return
    }

    polygons.map((polygon) => {
        polygon.setOptions({
            fillColor: '#8353a9',
            strokeColor: '#7300a9',
            strokeOpacity: 0.5,
            fillOpacity: 0.4
        })
    })
}

function recover(polygons) {
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

function clear(overlays) {
    if (overlays.length === 0) {
        return
    }

    for (let index = 0; index < overlays.length; index++) {
        overlays[index].setMap(null)
    }
}

/!* @Todo Enum 이슈 *!/
function getZoomLevelByTypeAndCode(typeOrCode) {
    let level;

    switch (typeOrCode) {
        case mapWeightType.Si: {
            level = 9;
            break
        }

        case mapWeightType.Gu: {
            level = 7;
            break
        }

        case mapWeightType.Dong: {
            level = 4;
            break
        }

        case 1: {
            level = 12;
            break
        }
        case 2: {
            level = 9;
            break
        }
        case 3: {
            level = 7;
            break
        }
    }

    return level
}

function addClassElement(target) {
    target.classList.add(clazz)
}

function removeClassElement(target, clazz) {
    target.classList.remove(clazz)
}

function isContainClass(target, clazz) {
    return target.classList.contains(clazz)
}
*/
