function getAddress() {
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

            document.getElementById('road').value = roadAddr;
            document.getElementById('jibun').value = data.jibunAddress;

            $('#jibun').removeClass('invalid b-1r');
            $('#road').removeClass('invalid b-1r');

            isFindAddress = true;
        }
    }).open({
        autoClose: true
    });
}
