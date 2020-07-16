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
function activate_with_selector(selector) {
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
function activate_with_url(regex, callback = null) {
    $(document).ready(() => {
        let el = window.location.pathname.replace(regex, "");

        if(callback != null) {
            el = callback(el);
        }

        $("#" + el).addClass("active");
    })
}
