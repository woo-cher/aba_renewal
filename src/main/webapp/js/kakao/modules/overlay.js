document.write("<script src='/js/kakao/factory/dom-creator.js'></script>");
document.write("<script src='/js/kakao/ajax/ajax-repository.js'></script>");

class Overlay extends KakaoMap {
    polygons = [];
    target = undefined;
    targetId = NaN;
    last = [];

    constructor(mapElement) {
        super(mapElement);

        this.overlays = [];
        this.eventManager = null;
        this.cacheMap = new Map();
    }

    clear() {
        if (this.overlays.length === 0) {
            return;
        }

        this.overlays.map((overlay) => {
            overlay.setMap(null);
        });
    }

    drawOverlays(weight, southWest, northEast) {
        getAllOverlays(weight, southWest, northEast).map((overlay) => {
            const overlayElement = new CustomDomCreator(overlay.id);

            overlayElement.setTitle(weight, overlay.name);
            overlayElement.setCount(weight, overlay.count);

            this.mouseEnterListener(overlayElement, overlay, weight);
            this.mouseLeaveListener(overlayElement, overlay, weight);
            this.mouseClickListener(overlayElement, overlay, weight);

            let weightCode = Object.keys(mapWeightType)[weight - 1];
            this.mouseDblClickListener(overlayElement, overlay, weightCode);

            const kakaoOverlay = super.getCustomOverlay({
                map: this.map,
                position: super.getKakaoLatlng(overlay.latitude, overlay.longitude),
                content: overlayElement.getOverlayContents(weight),
                clickable: true,
                yAnchor: 1
            });

            this.overlays.push(kakaoOverlay);

            this.polygons = []
        })
    }

    mouseEnterListener(overlayDom, overlay, weight) {
        overlayDom.customEventListener(weight, 'mouseenter', () => {
            clearTimeout(this.eventManager);

            if(!this.target) {
                this.recover(this.last);
            }

            this.eventManager = setTimeout(() => {
                if (!this.cacheMap.has(overlay.id)) {
                    this.polygons = this.getPolygons(getCoordinates(overlay.id));
                    this.last = this.polygons;
                    this.cacheMap.set(overlay.id, this.polygons);
                    this.paint(this.polygons)
                } else {
                    this.polygons = this.cacheMap.get(overlay.id);

                    this.paint(this.polygons);
                    this.last = this.polygons;
                }
            }, 0)
        });
    }

    mouseLeaveListener(overlayDom, overlay, weight) {
        overlayDom.customEventListener(weight, 'mouseleave', () => {
            if (!this.isContainClass(overlayDom.getInner(), 'clickable')) {
                this.recover(this.cacheMap.get(overlay.id))
            }
        });
    }

    mouseClickListener(overlayDom, overlay, weight) {
        overlayDom.customEventListener(weight, 'click', () => {
            // this.saleList.showLoading();
            // this.saleList.pageReset();

            if (overlay.id === this.targetId) {
                return
            }

            if (this.target !== undefined) {
                this.removeClassElement(this.target, 'clickable');
                this.recover(this.cacheMap.get(this.targetId))
            }

            if (event !== undefined) {
                this.target = event.currentTarget;
                this.targetId = overlay.id
            }

            this.addClassElement(this.target, 'clickable');

            if(weight === 1) {
                updateOffers(null, null, overlay.belongsTo);
            } else {
                updateOffers(null, null, overlay.name);
            }

            // 로딩바 숨김
            // await setTimeout(this.saleList.hideLoading(), 1000)
        });
    }

    mouseDblClickListener(overlayDom, overlay, weightCode) {
        overlayDom.customEventListener(weightCode,'dblclick', () => {
            this.recover(this.cacheMap.get(this.targetId));
            this.setCenter(overlay.latitude, overlay.longitude);
            this.setLevel(this.getLevelWhenOverlayDoubleClick(weightCode), {
                animate: {
                    duration: 350
                }
            });
        });
    }

    fieldClear() {
        this.target = undefined;
        this.targetId = NaN;
    }
}
