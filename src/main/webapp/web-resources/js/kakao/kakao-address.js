function getAddress(target) {
    new daum.Postcode({
        oncomplete: function(data) {
            let roadAddr = data.roadAddress; // 도로명 주소 변수
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

            if(target) {
                document.getElementById(target).value = data.jibunAddress;
            } else {
                document.getElementById('road').value = roadAddr;
                document.getElementById('jibun').value = data.jibunAddress;
            }

            $('#jibun').removeClass('invalid b-1r');
            $('#road').removeClass('invalid b-1r');

            let result = searchKakaoAddress(data.jibunAddress)['documents'][0];

            if(target === "jibun2") {
                $('#latitude2').val(result['y']);
                $('#longitude2').val(result['x']);

                loadMapMaker("locationMap2", result['y'], result['x'])
            } else {
                $('#latitude').val(result['y']);
                $('#longitude').val(result['x']);

                loadMapMaker("locationMap", result['y'], result['x'])
            }

            isFindAddress = true;
        }
    }).open({
        autoClose: true
    });
}
