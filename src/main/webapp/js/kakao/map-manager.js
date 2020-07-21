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

                }
            }

            if (this.weight > 7 && this.weight < 10) {

            } else if (this.weight > 4 && this.weight < 8) {

            } else if (this.weight < 5) {

            }

            // this.getPropertiesByPage()
        })
    }

    updateMapElements(weight) {
        switch (weight) {
            case 1:
                this.drawOverlays(weight);
        }
        if (weight === 1) {
            this.drawOverlays(weight);
        } else if (weight === 2) {

        } else if (weight === 3) {

        }
    }
}
