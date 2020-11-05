class PageHelper {
    constructor(pageLength = 5) {
        this.startPage = 1;
        this.endPage = 0;
        this.pageLength = pageLength;
    }

    setEndPage(endPage) {
        this.endPage = endPage;
    }

    // Page Calculate
    pageCalculation(startPage, pageInfo, callback) {
        let count = 0;

        $('.pages').empty();

        for (let num = startPage; num <= pageInfo['pages']; num++) {
            if (count !== this.pageLength) {
                let pageElement = document.createElement('li');

                if (num === pageInfo['pageNum']) {
                    pageElement.classList.add("active");
                }

                pageElement.innerText = num;
                pageElement.onclick = () => callback(num);

                $('.pages').append(pageElement);

                count++;
            }
        }

        activateWithSelector($('.pages > li'));
    }

    prevOrNext(pageParam, caller) {
        if(pageParam < 0 || pageParam > this.endPage) {
            return
        }

        this.startPage = pageParam;

        caller();
    }

    onChecked(focus) {
        let target = focus.parents('tr');
        target.hasClass('checked') ? target.removeClass('checked') : target.addClass('checked')
    }
}
