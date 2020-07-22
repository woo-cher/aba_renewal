document.write("<script src='/js/kakao/factory/dom-creator.js'></script>");
document.write("<script src='/js/kakao/ajax/ajax-repository.js'></script>");

class Overlay extends KakaoMap {
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

    drawOverlays(weightType, southWest, northEast) {
        getAllOverlays(weightType, southWest, northEast).map((ovl) => {
            const overlayElement = new CustomDomCreator(ovl.id);

            overlayElement.setTitle(weightType, ovl.name);
            overlayElement.setCount(weightType, ovl.count);

            let polygons = [];

            // this.focusInListener(overlayElement, weightType);
            // this.focusOutListener(overlayElement, weightType);
            // this.clickListener(overlayElement, weightType);
            // this.dbClickListener(overlayElement, weightType);

            const overlay = super.getCustomOverlay({
                map: this.map,
                position: super.getKakaoLatlng(ovl.centerX, ovl.centerY),
                content: overlayElement.getOverlayContents(weightType),
                clickable: true,
                yAnchor: 1
            });

            this.overlays.push(overlay);

            polygons = []
        })
    }

    // focusInListener(overlay, weightType) {
    //     overlay.customEventListener(weightType, 'mouseenter', async () => {
    //         await clearTimeout(this.eventManager);
    //
    //         if (this.last !== null) {
    //             await recover(this.last)
    //         }
    //
    //         this.eventManager = await setTimeout(() => {
    //             if (!this.cacheMap.has(ovl.id)) {
    //                 Promise.resolve(this.repository.getCoordinates(ovl.id)).then(
    //                     async (ovl: any) => {
    //                         polygons = await KakaoMap.getPolygons(ovl);
    //                         this.last = polygons;
    //                         this.cacheMap.set(ovl.id, polygons);
    //                         paint(polygons)
    //                     }
    //                 )
    //             } else {
    //                 paint(this.cacheMap.get(ovl.id))
    //             }
    //         }, 0)
    //     });
    // }
    //
    // focusOutListener(overlay, weightType) {
    //     overlay.customEventListener(weightType, 'mouseleave', async () => {
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
    // clickListener(overlay, weightType) {
    //     overlay.customEventListener(weightType, 'click', async () => {
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
    // dbClickListener(overlay, weightType) {
    //     overlay.customEventListener(weightType, 'dblclick', () => {
    //         recover(this.cacheMap.get(ovl.id));
    //         KakaoMap.map.setCenter(ovl.centerX, ovl.centerY);
    //         KakaoMap.map.setLevel(getZoomLevelByTypeAndCode(weightType), {
    //             animate: {
    //                 duration: 350
    //             }
    //         })
    //     });
    // }
}
