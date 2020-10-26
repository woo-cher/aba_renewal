<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">

<div class="right-header">
    <header>
        사용자 정보
        <i class="fas fa-address-card"></i>
        <span class="pt-1 mini-header">회원정보를 상세히 조회합니다.</span>
    </header>
</div>
<div class="right-content p-1 flex">
    <div class="column w-half mr-1">
        <div class="box mb-1">
            <header class="aba">
                <i class="fas fa-circle"></i>
                <span>기본정보</span>
            </header>
            <div class="box-content">
                <div class="row flex item-center">
                    <label>프로필</label>
                    <img width="200"
                         src="https://abasystem.s3.ap-northeast-2.amazonaws.com/offer-images/70efdf2ec9b086079795c442636b55fb/a29df2d7efa890382afa8844d22626ca"
                    >
                    <input type="hidden" class="w-65" readonly value="path">
                </div>
                <div class="row">
                    <label>아이디</label>
                    <input type="text" class="w-25" readonly value="${user.userId}">
                    <label class="align-center p-0">닉네임</label>
                    <input type="text" class="w-25" readonly value="${user.nickName}">
                </div>
                <div class="row">
                    <label>사용자유형</label>
                    <input type="text" class="w-25 aba" readonly value="${user.type.value} (${user.type.code})">
                    <label class="align-center p-0">권한</label>
                    <input type="text" class="w-25 aba" readonly value="${user.role.value} (${fn:replace(user.role.code, "ROLE_", "")})">
                </div>
                <div class="row">
                    <label>연락처</label>
                    <input type="text" class="w-65" readonly value="${user.phone}">
                </div>
            </div>
        </div>

        <div class="box">
            <header class="aba">
                <i class="fas fa-circle"></i>
                <span>추가정보</span>
            </header>
            <div class="box-content">
                <div class="row">
                    <label>상호명</label>
                    <input type="text" class="w-65 aba" readonly value="${user.agentName}">
                </div>
                <div class="row">
                    <label>업소 등록번호</label>
                    <input type="text" class="w-65" readonly value="${user.agentNumber}">
                </div>
                <div class="row">
                    <label>사무실 연락처</label>
                    <input type="text" class="w-65" readonly value="${user.agentPhone}">
                </div>
            </div>
        </div>
    </div>
    <div class="column w-half">
        <div class="box mb-1">
            <header class="aba">
                <i class="fas fa-circle"></i>
                <span>개인정보</span>
            </header>
            <div class="box-content">
                <div class="row">
                    <label>이메일주소</label>
                    <input type="text" class="w-65" readonly value="${user.email}">
                </div>
                <div class="row">
                    <label>지번주소</label>
                    <input type="text" class="w-65" readonly value="${user.jibunAddr}">
                </div>
                <div class="row">
                    <label>도로명주소</label>
                    <input type="text" class="w-65" readonly value="${user.roadAddr}">
                </div>
                <div class="row">
                    <label>상세주소</label>
                    <input type="text" class="w-65" readonly value="${user.extraAddr}">
                </div>
            </div>
        </div>

        <div class="box">
            <header class="aba">
                <i class="fas fa-circle"></i>
                <span>결제정보</span>
            </header>
            <div class="box-content">
                <div class="row">
                    <h1 class="aba align-center">준비중입니다 :)</h1>
                </div>
            </div>
        </div>
    </div>
</div>
