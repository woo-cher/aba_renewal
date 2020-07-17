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
        selector.parent()
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

        if(callback != null) {
            el = callback(el);
        }

        $("#" + el).addClass("active");
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
