function searchUser(keyword, page) {
    let result;

    $.ajax({
        url: '/apis/users/search?keyword=' + keyword + '&page=' + page,
        type: 'GET',
        async: false,
        contentType: 'application/json',
        success: function (requests) {
            result = requests;
        },
        error: ajaxError
    });

    return result;
}
