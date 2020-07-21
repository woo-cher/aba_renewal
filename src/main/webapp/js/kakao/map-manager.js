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
            this.weight = this.getMapLevel();
            this.getBoundElement();
            this.recover(this.cacheMap.get(this.targetId));
            this.relayout();

            this.southWest = this.getSouthWest();
            this.northEast = this.getNorthEast();

            console.log('evt active !! : ', evt, this.weight);

            this.clear();

            if (evt === 'zoom_changed') {
                if (this.weight > 9) {
                    // this.getOverlaysAndDrawTemplate(1, WeightCustomType.Sd)
                }
            }

            if (this.weight > 7 && this.weight < 10) {
                // this.getOverlaysAndDrawTemplate(2, WeightCustomType.Sgg)
            } else if (this.weight > 4 && this.weight < 8) {
                // this.getOverlaysAndDrawTemplate(3, WeightCustomType.Emd)
            } else if (this.weight < 5) {
                // this.drawBuildingSpots()
            }

            // this.getPropertiesByPage()
        })
    }
}
