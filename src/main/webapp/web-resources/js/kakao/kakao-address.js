function getAddress(target) {
    new daum.Postcode({
        oncomplete: function(data) {
            let roadAddr = data.roadAddress; // 도로명 주소 변수
            let jibunAddr = data.jibunAddress;
            let extraRoadAddr = ''; // 참고 항목 변수

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            let keywordParam = jibunAddr === "" ? roadAddr : jibunAddr;
            let result = searchKakaoAddress(keywordParam)['documents'][0];
            setLatLngByRegion(target, result['y'], result['x']);

            if(target !== undefined) {
                let value = '';

                if (data.userSelectedType === 'R') { // If select `road addr`
                    value = data.roadAddress;
                } else { // If `jibun`
                    value = data.jibunAddress;
                }

                document.getElementById(target).value = value;
            } else {
                document.getElementById('road').value = roadAddr;
                document.getElementById('jibun').value = jibunAddr;
            }

            // 우편번호
            document.getElementById('post').value = data.zonecode;

            // 지번 주소를 선택 해야하는 유형인 경우, (예상 주소) 값을 지번으로 사용
            if(target === undefined) {
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('road').value = expRoadAddr;
                } else if(data.autoJibunAddress) {
                    let expJibunAddr = data.autoJibunAddress;
                    document.getElementById('jibun').value = expJibunAddr;
                }
            }

            $('#jibun').removeClass('invalid b-1r');
            $('#road').removeClass('invalid b-1r');

            isFindAddress = true;
        }
    }).open({
        autoClose: true
    });
}

function setLatLngByRegion(target, latitude, longitude) {
    let latInputId = "latitude";
    let lngInputId = "longitude";
    let mapIdForMarker = "locationMap";

    // like `latitude2` ...
    if(target === "jibun2") {
        latInputId += "2";
        lngInputId += "2";
        mapIdForMarker += "2";
    }

    $('#' + latInputId).val(latitude);
    $('#' + lngInputId).val(longitude);

    if(target === undefined) {
        return
    }

    loadMapWithMarker(mapIdForMarker, latitude, longitude);
}
