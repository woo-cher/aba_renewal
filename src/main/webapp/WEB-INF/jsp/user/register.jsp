<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>회원가입</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/component/form.css">
    <script src="/js/jquery-utils.js"></script>

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>
<body>
<div class="main-container">
    <article class="content-wrap">
        <div class="content-name" id="top">
            <h3>
                <span class="aba">아바</span>
                <span class="header mini">회원가입</span>
            </h3>
        </div>

        <section class="form-control" id="agree-area">
            <ul class="checkbox-container p-0">
                <li class="absolute">
                    <input id="agree-all" type="checkbox" name="agree" value="" class="check">
                    <label for="agree-all" onclick="agreeAll()">
                        <span class="aba">'모든 약관'</span> 에 동의합니다.
                    </label>
                </li>
            </ul>
            <%-- Agree --%>
            <form id="agree-form">
            <c:forEach begin="0" end="3" varStatus="status">
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>${keys[status.index]}</span>
                    </div>
                    <div class="form-category agree">
                        <c:import url="/WEB-INF/jsp/agree/${values[status.index]}.jsp" />
                    </div>
                    <ul class="checkbox-container agree">
                        <li>
                            <input id="agree${status.index}" type="checkbox" name="agree" value="" class="check">
                            <label for="agree${status.index}">
                                <span class="aba">'${keys[status.index]}'</span> 에 동의합니다.
                            </label>
                        </li>
                    </ul>
                </div>
            </c:forEach>
            </form>
            <button class="login-button" id="join" type="submit" onclick="agreeChecker()">가입하기</button>
        </section>

        <section class="form-control" id="register-area" hidden>
            <%-- Form --%>
            <form id="registerForm" action="/users/create" method="post">
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>기본항목</span>
                    </div>
                    <div class="form-category">
                        <div class="form-label">
                            <span class="form-label mini">
                                <i class="fas fa-users"></i>
                                회원유형
                            </span>
                        </div>
                        <ul class="checkbox-container form">
                            <li class="checkbox-list">
                                <input id="qq" type="radio" name="type" value="OWNER" class="check">
                                <label for="qq">집주인</label>
                            </li>
                            <li class="checkbox-list">
                                <input id="ww" type="radio" name="type" value="BROKER" class="check">
                                <label for="ww">공인중개사</label>
                            </li>
                            <li class="checkbox-list">
                                <input id="ee" type="radio" name="type" value="ASSISTANT" class="check">
                                <label for="ee">중개보조원</label>
                            </li>
                        </ul>
                        <input required autofocus type="text" placeholder="아이디" name="userId"
                               pattern="^([A-Za-z0-9])+"
                               oninvalid="this.setCustomValidity(`공백, 특수문자 또는 한글이 포함되네요 :(`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                        >
                        <input required autofocus type="password" placeholder="비밀번호" name="password"
                               oninvalid="this.setCustomValidity(`비밀번호를 입력해주세요 :)`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                        >
                        <input required autofocus type="password" placeholder="비밀번호 확인"
                               oninvalid="this.setCustomValidity(`비밀번호를 입력해주세요 :)`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                        >
                        <input required autofocus type="text" placeholder="닉네임" name="nickName">
                        <p class="error" hidden>
                            <i class="fas fa-exclamation-circle">
                            Error Message
                            </i>
                        </p>
                    </div>
                </div>
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>개인정보</span>
                    </div>
                    <div class="form-category">
                        <input required autofocus type="text" placeholder="이름" name="name">
                        <div class="input-group">
                            <input required autofocus type="text" class="middle" placeholder="이메일" name="email">
                            <p class="mail"><i class="fas fa-at"></i></p>
                            <input required autofocus type="text" class="middle" placeholder="도메인" name="email">
                        </div>
                        <div class="input-group">
                            <input required autofocus type="text" class="short" placeholder="010" name="phone">
                            <p class="short">-</p>
                            <input required autofocus type="text" class="short" placeholder="####" name="phone">
                            <p class="short">-</p>
                            <input required autofocus type="text" class="short" placeholder="####" name="phone">
                        </div>
                        <div class="input-group">
                            <input required autofocus type="text" class="middle" placeholder="주소" name="jibunAddr">
                            <p class="addr"><i class="fas fa-search"></i></p>
                        </div>
                        <div class="input-group">
                            <input required autofocus type="text" class="middle" placeholder="아바아파트 3동" name="extraAddr">
                            <input required autofocus type="text" class="short" placeholder="510호" name="extraAddr">
                        </div>
                        <p class="error" hidden>
                            <i class="fas fa-exclamation-circle">
                                Error Message
                            </i>
                        </p>
                    </div>
                </div>
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>추가정보</span>
                    </div>
                    <div class="form-category">
                        <ul class="checkbox-container form">
                            <li class="checkbox-list">
                                <input id="1" type="checkbox" name="isEmailReception" value="" class="check">
                                <label for="1">이메일 수신 동의하기</label>
                            </li>
                            <li class="checkbox-list">
                                <input id="2" type="checkbox" name="isSmsReception" value="" class="check">
                                <label for="2">
                                    SMS 수신 동의하기
                                </label>
                            </li>
                            <li class="checkbox-list">
                                <input id="3" type="checkbox" name="isProfileOpen" value="" class="check">
                                <label for="3">
                                    프로필 공개 동의
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <button class="login-button" type="submit">회원가입</button>
            </form>
        </section>
    </article>
</div>

<%-- footer --%>
<%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</body>
</html>

<script>
    function agreeAll() {
        let agrees = $('input[name="agree"]');
        let isChecked = $('#agree-all').prop("checked");

        isChecked === true ? agrees.prop("checked", false) : agrees.prop("checked", true);

        // '모든약관' 라벨 체크 인식이 안되는 현상 임시 조치
        $("#agree-all").click();
        isChecked = true;

        agrees.next().removeClass('invalid');
        $('.error').remove();

        if(isChecked) {
            moveScroll($("#join").offset().top);
        }
    }

    function agreeChecker() {
        let selector;

        for(let i = 0; i < 4; i++) {
            selector = $('#agree' + i);

            selector.click(function() {
                selector.next().removeClass('invalid');
                selector.parent().siblings('.error').remove();
            });

            if( ! selector.is(':checked')) {
                moveScroll(selector.parent().offset().top - 15);

                if(!selector.next().hasClass('invalid')) {
                    selector.parents('ul')
                        .append(
                            '<p class="error agree">' +
                            '<i class="fas fa-exclamation-circle">' +
                            '</i> 항목에 동의해주세요 :)</p>'
                        );
                }

                selector.next().addClass('invalid');

                return
            }
        }

        $('#agree-area').hide();
        $("#register-area").show();

        moveScroll($("#top").offset().top);
    }
</script>
