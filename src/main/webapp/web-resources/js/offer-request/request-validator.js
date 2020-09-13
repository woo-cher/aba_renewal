function validatorProvider(processIndex) {
    switch (processIndex) {
        case 0:
            return dealTypeValidator();
        case 1:
            return moveInValidator();
        case 2:
            return offerTypeValidator();
        case 3:
            return pyeongAndRoomValidator();
        case 4:
            return locationValidator();
        case 5:
            return requiredConditionValidator();
    }
}

function dealTypeValidator() {
    let dealTypes = $('input[name="dealType"]');
    let isPassed = false;

    // Deal type check
    for(let i = 0; i < dealTypes.length; i++) {
        if($(dealTypes[i]).prop("checked")) {
            isPassed = true;
        }
    }

    return errorHandle(isPassed, "계약조건을 선택해주세요 :)");
}

function moveInValidator() {
    let moveIns = $('input[name="moveInOpener"]');
    let isPassed = false;

    for(let i = 0; i < moveIns.length; i++) {
        if($(moveIns[i]).prop('checked')) {
            isPassed = true;
        }
    }

    if(!isPassed) {
        return errorHandle(isPassed, "입주날짜를 선택해주세요 :)");
    }

    return isPassed;
}

function offerTypeValidator() {
    let offerTypes = $('input[name="offerRequestTypes"]');
    let isPassed = false;

    for(let i = 0; i < offerTypes.length; i++) {
        if($(offerTypes[i]).prop('checked')) {
            isPassed = true;
        }
    }

    return errorHandle(isPassed, "희망유형을 선택해주세요 :)");
}

function pyeongAndRoomValidator() {
    let pyeongValue = $('#pyeong').val();
    let roomValue = $('#room').val();
    let floorValue = $('#floor').val();

    if(floorValue === "") {
        return errorHandle(false, "희망 층을 선택해주세요 :)")
    }

    if(pyeongValue === "") {
        return errorHandle(false, "평수를 선택해주세요 :)");
    }

    if(roomValue === "") {
        return errorHandle(false, "방 갯수를 선택해주세요 :)");
    }

    return true;
}

function locationValidator() {
    let jibun = $('#jibun').val();
    let jibun2 = $('#jibun2').val();

    if(jibun === "") {
        return errorHandle(false, "선호 지역을 최소 1곳 선택해주세요 :)");
    }

    return true;
}

function requiredConditionValidator() {
    let requiredTypes = $('input[name="requiredConditions"]');
    let isPassed = false;

    for(let i = 0; i < requiredTypes.length; i++) {
        if($(requiredTypes[i]).prop('checked')) {
            isPassed = true;
        }
    }

    if(!isPassed) {
        return errorHandle(isPassed, "고려조건을 최소 1개 선택해주세요 :)")
    }

    return true;
}

function errorHandle(isPassed, message) {
    if(isPassed) {
        return isPassed;
    }

    $('#error').text(" " + message);
    $('.error').show();

    return false;
}
