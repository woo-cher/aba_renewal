function formValidatorWithRegex(focus, mode) {
    let idRegex = new RegExp(focus.attr('pattern'));
    let result = idRegex.exec(focus.val());

    if(mode === 'phone') {
        if(focus.val().length > 3) {
            $(focus).val(result);
        }
    } else {
        $(focus).val(result);
    }
}
