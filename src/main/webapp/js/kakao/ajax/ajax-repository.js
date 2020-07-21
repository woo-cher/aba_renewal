function getAllOverlays(weight) {
    let result;

    $.ajax({
        url: '/overlays/' + weight,
        async: false,
        success: function (overlays) {
            result = overlays;
        },
        error:ajaxError
    });

    return result;
}

function ajaxError() {
    alert("Error !");
}
