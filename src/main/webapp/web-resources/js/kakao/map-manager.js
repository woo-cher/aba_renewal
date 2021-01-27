class MapManager extends Spot {
    constructor(mapElement) {
        super(mapElement);

        this.mapEventListener('dragend');
        this.mapEventListener('zoom_changed');

        this.targetId = NaN;
        this.level = this.getMapLevel();
        this.southWest = this.getSouthWest();
        this.northEast = this.getNorthEast();
    }

    mapEventListener(evt) {
        this.kakaoEventListener(evt, () => {
            this.level = this.getMapLevel();

            this.recover(this.cacheMap.get(this.targetId));
            this.relayout();

            this.getBoundElement();
            this.southWest = this.getSouthWest();
            this.northEast = this.getNorthEast();
            this.clear();
            this.fieldClear();

            const weight = this.getWeightByZoomLevel(this.level);
            this.drawOverlays(weight, this.southWest, this.northEast);

            let pageInfo;

            /* If `spot` level */
            if(this.level < 4) {
                pageInfo = getOffersOfMap(this.southWest, this.northEast, null, 0);
                this.drawSpots(pageInfo['list']);
            }

            pageInfo = getOffersOfMap(this.southWest, this.northEast, null, 1);
            this.updateOffersAndPages(1, pageInfo, '',this.getIsPremium());
        })
    }

    getWeightByZoomLevel(nowLevel) {
        if (nowLevel > 9) {
            return 1;
        } else if (nowLevel > 7 && nowLevel < 10) {
            return 2;
        } else if (nowLevel > 3 && nowLevel < 8) {
            return 3;
        }
    }
}
