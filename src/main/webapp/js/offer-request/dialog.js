function dialogInitialize() {
    $('#select-pyeong').on('click', function () {
        $('.overlay').toggle();
        $('#pyeong-dialog').dialog({
            close: function (event, ui) {
                $('.overlay').toggle();
            }
        });
    });

    $('#select-room').on('click', function () {
        $('.overlay').toggle();
        $('#room-dialog').dialog({
            close: function (event, ui) {
                $('.overlay').toggle();
            }
        });
    });

    $('#pyeong-dialog > li').click(function (e) {
        let val = e.currentTarget.innerHTML;

        $('#pyeong').val(val);
        $('#pyeong-txt').text(val);
        $('#pyeong-dialog').dialog('close');
    });

    $('#room-dialog > li').click(function (e) {
        let val = e.currentTarget.innerHTML;

        $('#room').val(val);
        $('#room-txt').text(val);
        $('#room-dialog').dialog('close');
    });
}
