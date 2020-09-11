document.write("<script src='/web-resources/js/kakao/factory/dom-factory.js'></script>");

class CustomDomCreator {
    constructor(overlayId) {
        this.factory = new CustomDomFactory();

        /* Overlay dom */
        this.wrapper = this.factory.getWrapper();
        this.inner = document.createDocumentFragment();
        this.title = document.createDocumentFragment();
        this.count = document.createDocumentFragment();

        /* Spot dom */
        this.spotContents = document.createDocumentFragment();

        if(!isNaN(overlayId)) {
            this.inner = this.factory.getInner(overlayId);
        }
    }

    getInner() {
        return this.inner;
    }

    setTitle(weightType, overlayName) {
        this.title = this.factory.getTitleDom(weightType, overlayName);
    }

    setCount(weightType, overlayCount) {
        if (weightType === mapWeightType.Si) {
            return 'This is only used of weightType: 시군구(2) or 읍면동(3)';
        }

        this.count = this.factory.getCountDom(overlayCount)
    }

    // Issue: IE 에서 append 속성 지원이 되지 않는 현상
    getOverlayContents(type) {
        this.undefinedChecker(this.wrapper, this.inner);
        // this.wrapper.append(this.inner)
        // this.inner.append(this.title)

        if (type !== mapWeightType.Sd) {
            this.undefinedChecker(this.title);
            this.title.appendChild(this.count);
        }

        this.inner.appendChild(this.title);
        this.wrapper.appendChild(this.inner);

        return this.wrapper
    }

    setSpotContents(countValue, idValue) {
        idValue = idValue.toString().replace('.', '');
        this.spotContents = this.factory.getSpotContents(countValue, idValue)
    }

    getSpotContents() {
        this.undefinedChecker(this.spotContents);
        return this.spotContents
    }

    customEventListener(type, evt, callback) {
        if (type === mapWeightType.Spot) {
            this.spotContents.addEventListener(evt, () => {
                callback()
            })
        } else {
            this.inner.addEventListener(evt, () => {
                callback()
            })
        }
    }

    undefinedChecker(...param) {
        param.map((parameter) => {
            if (parameter === undefined) {
                throw new DOMException(
                    parameter +
                    ' object is undefined. Please initializing with setter method'
                )
            }
        })
    }
}
