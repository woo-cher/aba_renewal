document.write("<script src='/js/kakao/factory/dom-creator.js'></script>");
document.write("<script src='/js/kakao/ajax/ajax-repository.js'></script>");

class Overlay extends KakaoMap {
    polygons = [];

    constructor(mapElement) {
        super(mapElement);

        this.overlays = [];
        this.eventManager = null;
        this.cacheMap = new Map();
    }

    clear() {
        if (this.overlays.length === 0) {
            console.log('0');
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

            let weightCode = Object.keys(mapWeightType)[weight - 1];

            // this.focusInListener(overlayElement, weight);
            // this.focusOutListener(overlayElement, weight);
            // this.clickListener(overlayElement, weight);

            this.dbClickListener(overlayElement, overlay, weightCode);

            const kakaoOverlay = super.getCustomOverlay({
                map: this.map,
                position: super.getKakaoLatlng(overlay.centerX, overlay.centerY),
                content: overlayElement.getOverlayContents(weight),
                clickable: true,
                yAnchor: 1
            });

            this.overlays.push(kakaoOverlay);

            this.polygons = []
        })
    }

    // focusInListener(overlayDom, overlay, weight) {
    //     overlayDom.customEventListener(weight, 'mouseenter', () => {
    //         clearTimeout(this.eventManager);
    //
    //         if (this.last !== null) {
    //             this.recover(this.last)
    //         }
    //
    //         this.eventManager = setTimeout(() => {
    //             if (!this.cacheMap.has(ovl.id)) {
    //                 Promise.resolve(this.repository.getCoordinates(ovl.id)).then(
    //                     async (ovl: any) => {
    //                         this.polygons = KakaoMap.getPolygons(ovl);
    //                         this.last = polygons;
    //                         this.cacheMap.set(ovl.id, polygons);
    //                         paint(polygons)
    //                     }
    //                 )
    //             } else {
    //                 this.paint(this.cacheMap.get(ovl.id))
    //             }
    //         }, 0)
    //     });
    // }
    //
    // focusOutListener(overlay, weight) {
    //     overlay.customEventListener(weight, 'mouseleave', async () => {
    //         // this.eventManager = await setTimeout(async () => {
    //         if (this.target === undefined) {
    //             await recover(this.cacheMap.get(ovl.id));
    //             return
    //         }
    //
    //         if (!isContainClass(overlayElement.getInner(), 'clickable')) {
    //             recover(this.cacheMap.get(ovl.id))
    //         }
    //         // }, 50)
    //     });
    // }
    //
    // clickListener(overlay, weight) {
    //     overlay.customEventListener(weight, 'click', async () => {
    //         // this.saleList.showLoading();
    //         // this.saleList.pageReset();
    //
    //         if (ovl.id === this.targetId) {
    //             return
    //         }
    //
    //         if (this.target !== undefined) {
    //             removeClassElement(this.target, 'clickable');
    //             recover(this.cacheMap.get(this.targetId))
    //         }
    //
    //         if (event !== undefined) {
    //             this.target = event.currentTarget;
    //             this.targetId = ovl.id
    //         }
    //
    //         Promise.resolve(
    //             await this.repository.getPropertiesByBelongs(ovl.name, this.filterDto)
    //         ).then((data) => {
    //             KakaoMap.propertiesInRect = data;
    //             KakaoMap.doUpdated = false
    //         });
    //
    //         addClassElement(this.target, 'clickable');
    //
    //         // 로딩바 숨김
    //         // await setTimeout(this.saleList.hideLoading(), 1000)
    //     });
    // }
    //
    dbClickListener(overlayDom, overlay, weightCode) {
        overlayDom.customEventListener(weightCode,'dblclick', () => {
            // this.recover(this.cacheMap.get(overlayDom.id));

            this.setCenter(overlay.centerX, overlay.centerY);
            this.setLevel(this.getLevelWhenOverlayDoubleClick(weightCode), {
                animate: {
                    duration: 350
                }
            })
        });
    }
}
