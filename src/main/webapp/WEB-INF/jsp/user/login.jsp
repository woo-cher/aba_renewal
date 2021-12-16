<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Login</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">
    <link rel="stylesheet" type="text/css" href="/web-resources/css/login.css">
    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>

    <style>
        .main-container {
            height: calc(70% - 70px);
            padding: 5% 0 7% 0 !important;
        }

        #form-box {
            width : 47% !important;
        }

        #footer {
            height: 30%;
        }
    </style>
</head>

<body class="over-hide">
<div class="main-container">
        <section id="contents">
            <article id="form-box">
                <div class="content-name">
                    <h3>
                        <span class="aba">아바</span>
                        <span class="header mini">로그인</span>
                    </h3>
                </div>
                <section class="form-control">
                    <form class="id-pw" action="/auth/doLogin" method="post">
                        <label>
                            <input required autofocus type="text" class="id" placeholder="아이디" name="username"
                                   pattern="^([A-Za-z0-9])+"
                                   oninvalid="this.setCustomValidity(`공백, 특수문자 또는 한글이 포함되네요 :(`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   autocomplete="off"
                            >
                        </label>
                        <label>
                            <input required autofocus type="password" class="pw" placeholder="비밀번호" name="password"
                                   oninvalid="this.setCustomValidity(`비밀번호를 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                            >
                        </label>
                        <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
                        <p class="error">
                            <i class="fas fa-exclamation-circle"></i>
                            아이디 또는 비밀번호가 일치하지 않아요 :(
                        </p>
                        </c:if>
<%--                        <div class="check-box">--%>
<%--                            <input type="checkbox" class="login-save" name="" value="save">&nbsp; 아이디 저장--%>
<%--                            <input type="checkbox" class="auto-login" name="" value="auto">&nbsp; 자동로그인--%>
<%--                        </div>--%>
                        <button class="login-button" type="submit">로그인</button>
                    </form>
                    <div class="nav-box">
                        <div class="join">
                            <h3>아직도 회원이 아니신가요?</h3>
                            <button onclick="location.href='/users/form'">회원가입</button>
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
    </div>

    <%-- footer --%>
    <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</body>
</html>
