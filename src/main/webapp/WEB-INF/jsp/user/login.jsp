<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/login.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>
<body>
    <div id="wrap">
        <section id="contents">
            <article id="con-box">
                <div class="login-name">
                    <h3>회원 로그인</h3>
                </div>
                <section class="box">
                    <form class="id-pw" action="/auth/doLogin" method="post">
                        <label>
                            <input required autofocus type="text" class="id" placeholder="아이디" name="username"
                                   pattern="^([A-Za-z0-9])+"
                                   oninvalid="this.setCustomValidity(`공백, 특수문자 또는 한글이 포함되네요 :(`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                            >
                        </label>
                        <label>
                            <input required autofocus type="password" class="pw" placeholder="비밀번호" name="password"
                                   oninvalid="this.setCustomValidity(`비밀번호를 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                            >
                        </label>
                        <p class="error">
                            <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
                                아이디 또는 비밀번호가 일치하지 않네요 :(
                            </c:if>
                        </p>
                        <div class="check-box">
                            <input type="checkbox" class="login-save" name="" value="save">&nbsp; 아이디 저장
                            <input type="checkbox" class="auto-login" name="" value="auto">&nbsp; 자동로그인
                        </div>
                        <button class="login-button" type="submit">로그인</button>
                    </form>
                    <div class="nav-box">
                        <div class="join">
                            <h3>아직도 회원이 아니신가요?</h3>
                            <button>회원가입</button>
                        </div>
                        <div class="find">
                            <h3>아이디/비밀번호를 잊으셨나요?</h3>
                            <button class="id-find">아이디 찾기</button>
                            <button class="pw-find">비밀번호 찾기</button>
                        </div>
                    </div>
                </section>
            </article>
        </section>

        <%-- footer --%>
        <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
    </div>

</body>
</html>
