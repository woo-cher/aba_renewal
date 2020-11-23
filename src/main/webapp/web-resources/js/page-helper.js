/**
 * Must import <script src='.../paginator.js'> in view file
 * can using `Document.write()`, but if there is a network delay issue, it is not a good method
 */
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

        if (pageInfo['list'].length === 0) {
            $('.pages').append(`<li class="active">1</li>`);
        } else {
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

    getEmptyRowElement(colspan) {
        return `<tr><td colspan="${colspan}" class="aba txt-lg p-3">결과가 존재하지 않아요 :(</td></tr>`;
    }
}

function onChecked(focus) {
    let target = focus.parents('tr');
    target.hasClass('checked') ? target.removeClass('checked') : target.addClass('checked')
}
