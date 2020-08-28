/**
 * For example,
 *
 * <ul>                            <-- `selector.parent()`
 *     <li class="active"></li>
 *     <li></li>                   <-- `selector`
 * </ul>
 *
 * @param selector
 */
function activateWithSelector(selector) {
    $(selector).click((e) => {
        $(selector).parent()
            .find('.active')
            .removeClass('active');

        e.currentTarget.classList.add('active');
    })
}

/**
 * For example,
 *
 * Page url like '/maps'
 * By the `regex`, url element change `/maps` to `maps`
 * As a result, Target selector is < ... id="maps" ...>
 * Finally, < ... id="maps" class="active" ... >
 *
 * If necessary, you define `callback` function :)
 *
 * @param regex
 * @param callback
 */
function activateWithUrl(regex, callback = null) {
    $(document).ready(() => {
        let el = window.location.pathname.replace(regex, "");

        if (callback != null) {
            el = callback(el);
        }

        if (el.includes("payment") || el.includes("account")) {
            $('#usersmemyaba').addClass('active');
        }

        $('#' + el).addClass('active');
    })
}

/**
 * `eventTarget` children index and `hideWhat` children index must be the same.
 *
 * For Example,
 * If exist side navigation bar like below,
 * <ul>
 *     <li>First</li>
 *     <li>Second</li>
 *     <li>Third</li>
 * <ul>
 * `<li>` is `eventTarget`.
 *
 * Next, `hideWhat` is the target for hide when on `click` event.
 * And, `showWhat` is the target for show when `hideWhat` is hided.
 *
 * @param eventTarget
 * @param hideWhat
 * @param showWhat
 */
function switchContentViewWithIndex(eventTarget, hideWhat, showWhat) {
    $(eventTarget).click(function () {
        let i = $(eventTarget).index(this);

        $(hideWhat).hide();
        $(showWhat).children().eq(i).show();
    })
}

function getUrlParameter(reqParam) {
    let pageUrl = window.location.search.substring(1),
        value = pageUrl.split('&'),
        name,
        i;

    for (i = 0; i < value.length; i++) {
        name = value[i].split('=');

        if (name[0] === reqParam) {
            return name[1] === undefined ? true : decodeURIComponent(name[1]);
        }
    }
}

function getElement() {
    return `<div class="box">
            <div class="content label">
                <div class="label-wrap">비밀번호 변경</div>
            </div>
            <div class="content avatar p-0">
                <img class="w-25" src="/img/guide.jpg">
                <div class="content p-0">
                    <div class="w-full">
                        <span class="rank d-mark">D</span>
                        <span class="txt-lg">아바</span>&nbsp;님
                    </div>
                </div>
            </div>
            <div class="box f-c w-half">
                <form class="form-control p-0">
                    <input required autofocus type="password" class="pw" placeholder="기존 비밀번호를 입력해주세요 :)" name="password"
                           oninvalid="this.setCustomValidity(\`비밀번호를 입력해주세요 :)\`)"
                           oninput="this.setCustomValidity(''); this.checkValidity()"
                    >
                    <div class="content align-center">
                        <button class="btn inline" type="submit">확인</button>
                    </div>
                </form>
            </div>
        </div>
   `
}
