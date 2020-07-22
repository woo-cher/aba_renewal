class MapManager extends Spot {
    constructor(mapElement) {
        super(mapElement);

        this.mapEventListener('dragend');
        this.mapEventListener('zoom_changed');

        this.targetId = NaN;
        this.southWest = .0;
        this.northEast = .0;
    }

    mapEventListener(evt) {
        this.kakaoEventListener(evt, () => {
            const level = this.getMapLevel();

            this.recover(this.cacheMap.get(this.targetId));
            this.relayout();

            this.getBoundElement();
            this.southWest = this.getSouthWest();
            this.northEast = this.getNorthEast();

            console.log('on ' + evt + ' active');

            this.clear();
            this.fieldClear();
            const weight = this.getWeightByZoomLevel(level);

            this.drawOverlays(weight, this.southWest, this.northEast);
            // this.getPropertiesByPage()
        })
    }

    getWeightByZoomLevel(nowLevel) {
        if (nowLevel > 9) {
            console.log('시/도');
            return 1;
        } else if (nowLevel > 7 && nowLevel < 10) {
            console.log('시/군/구');
            return 2;
        } else if (nowLevel > 3 && nowLevel < 8) {
            console.log('읍/면/동');
            return 3;
        }
    }
}
