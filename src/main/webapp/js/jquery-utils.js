/**
 * Define commons action of `jquery`
 * For example, `screen scrolled` ...
 *
 * @Custom
 * @param offset
 */
function moveScroll(offset) {
    $('html, body').animate({
        scrollTop: offset
    }, 500);
}
