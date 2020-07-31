class MapManager extends Spot {
    constructor(mapElement) {
        super(mapElement);

        this.mapEventListener('dragend');
        this.mapEventListener('zoom_changed');

        this.targetId = NaN;
        this.level = this.getMapLevel();
        this.southWest = this.getSouthWest();
        this.northEast = this.getNorthEast();

        this.startPage = 1;
        this.pageLength = 5;
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

            this.updateOffersAndPages();
        })
    }

    updateOffersAndPages(page = 1) {
        let pageInfo = getOffersPageInfo(this.southWest, this.northEast, null, page);

        this.updateOffers(pageInfo['list']);
        this.bindPagination(pageInfo, $('.offer-list'));

        /* If `spot` level */
        if(this.level < 4) {
            pageInfo = getOffersPageInfo(this.southWest, this.northEast, null, 0);
            this.drawSpots(pageInfo['list']);
        }
    }

    bindPagination (pageInfo, offerArea) {
        const pageNum = pageInfo['pageNum'];

        if(this.startPage + 5 === pageNum) {
            this.startPage = pageNum;
        }

        if (!offerArea.hasClass("paginator")) {
            offerArea.append(`
                <div class="paginator">
                    <div class="page-wrap">
                        <button class="page prev" onclick="pagingCaller(${this.startPage - 5}, true)">
                            <img src="/img/basic/keyboard_arrow_left-24px.svg">
                        </button>
                        <ul class="pages" style="display: contents;"></ul>
                        <button class="page prev" onclick="pagingCaller(${this.startPage + 5}, false)">
                            <img src="/img/basic/keyboard_arrow_right-24px.svg">
                        </button>
                    </div>
                </div>
            `)
        }

        let count = 0;
        const pageArea = $('.pages');

        for(let num = this.startPage; num <= pageInfo['pages']; num++) {
            if(count !== this.pageLength) {
                pageArea.append(num === pageNum ? `<li class="active">${num}</li>` : `<li onclick="pagingCaller(${num})">${num}</li>`);
                count++;
            }
        }
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
