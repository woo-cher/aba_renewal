class Spot extends Overlay {
    constructor(mapElement) {
        super(mapElement);

        this.spotMap = new Map();
    }

    /**
     * @Flow
     *
     *  1. Create `kakao customOverlay() as spot` Using (latitude, longitude) of `offers`
     *  2. Check if exist `spot` in Map(K, V) of spot
     *
     *   > The `key` of Map() is value of (latitude + longitude)
     *   > The `value` of Map() is Object() of kakao's customOverlay()
     *
     *  3. If already exist, get `spot` from Map() and count value ++.
     *  4. Else, set `spot` to Map()
     *  5. Finally, add event listener about 'click'
     *
     * @param offers
     */
    drawSpots(offers) {
        const size = offers.length;

        if(size === 0) {
            return
        }

        const spotElement = new CustomDomCreator(NaN);

        for(let i = 0; i < size; i++) {
            const lat = offers[i].offerAddress.latitude;
            const lng = offers[i].offerAddress.longitude;

            const key = lat + lng;

            const spot = this.getCustomOverlay({
                map: this.map,
                position: this.getKakaoLatlng(lat, lng),
                clickable: true
            });

            if(this.spotMap.has(key)) {
                let value;
                const node = this.spotMap.get(key).getContent();

                node.firstChild.textContent++;
                value = node.getAttribute('value');
                node.setAttribute('value', value++);
            } else {
                spotElement.setSpotContents(1);
                spot.setContent(spotElement.getSpotContents());

                this.spotMap.set(key, spot);
            }

            this.overlays.push(spot); // for clear()

            spotElement.customEventListener(mapWeightType.Spot, 'click', () => {
                // getOffersByLatLng and updateOffers()

                if (this.target === event.currentTarget) {
                    return
                }

                if (this.target !== undefined) {
                    this.removeClassElement(this.target, 'clickable')
                }

                this.target = event.currentTarget;
                this.targetId = offers[i].id;
                this.addClassElement(this.target, 'clickable');
            })
        }

        this.spotMap.clear(); // reset
    }
}
