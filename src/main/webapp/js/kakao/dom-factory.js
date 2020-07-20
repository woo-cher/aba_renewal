class CustomDomFactory {
    constructor() {
        this.domParser = new DOMParser();
    }

    getWrapper() {
        const wrap = document.createElement('div');
        wrap.classList.add('customoverlay');

        return wrap
    }

    getInner(id) {
        const inner = document.createElement('a');

        inner.setAttribute('href', '#');
        inner.id = id;
        inner.classList.add('inner');

        return inner
    }

    getTitleDom(weightType, overlayName) {
        const domStr = document.createElement('span');

        if (weightType === mapWeightType.Si) {
            domStr.id = 'stitle';
            domStr.innerHTML = overlayName
        } else {
            domStr.id = 'title';

            const child = document.createElement('p');

            child.id = 'name';
            child.innerHTML = overlayName;

            domStr.appendChild(child)
        }

        return domStr
    }

    getCountDom(overlayCount) {
        const count = document.createElement('p');

        count.id = 'count';
        count.innerHTML = overlayCount.toString();

        return count
    }

    getSpotContents(countValue) {
        const spot = document.createElement('div');

        spot.id = 'customSpot';
        spot.classList.add('custom-spot-overlay');
        spot.setAttribute('value', countValue.toString());

        const child = document.createElement('p');

        child.id = 'spotCount';
        child.innerHTML = countValue.toString();

        spot.appendChild(child);

        return spot
    }
}
