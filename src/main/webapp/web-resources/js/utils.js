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

        if (el === '') {
            return;
        }

        if (callback != null) {
            el = callback(el);
        }

        /**
         * Specified
         */
        if (el.includes("usersme")) {
            $('.usersmemyaba').addClass('active');
        }

        if (el.includes("requestsmy")) {
            $(".requestsmycertified").addClass('active');
        }

        if (el.includes("offers")) {
            $(".adminoffers").addClass('active');
        }

        $('.' + el).addClass('active');
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

/**
 * Get parameter from url.
 * 
 * Url has QueryString parameters like '/users?userId=test'
 * => If want get `userId` parameter, can use getUrlParameter("userId").
 * 
 * As a result, {"userId": "test"}
 * 
 */
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

<!-- Dialog -->
function dialogInitializer(element, showWhat, targetName = null, targetId = null) {
    $('.overlay').show();
    showWhat.dialog({
        resizable: false,
        draggable: false,
        position: {
            my: "center",
            at: "center",
            of: ".dialog-yardstick"
        },
        open: function () {
            targetName !== null ? $('.target').text(targetName) : '';
            targetId !== null ? $('.target-id').val(targetId) : '';
        },
        close: function (event, ui) {
            $('.overlay').hide();
        }
    });
}

function dialogCloseTrigger(dialogElement) {
    dialogElement.dialog('close');
}
<!-- /Dialog -->

// For array swap
function removeSpecifiedElement(array, indexOf) {
    array.splice(indexOf, 1);
}

function isEnterKey(e) {
    return e.which === 13;
}
