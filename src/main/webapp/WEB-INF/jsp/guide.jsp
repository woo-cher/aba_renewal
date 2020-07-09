<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>아바 이용가이드</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/guide.css">
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
</head>
<body>
<div id="wrap">
    <div id="guide">
            <header class="logo">
                <img src="/img/logo.png" alt="아바로고" onclick="location.href='../..'">
            </header>
            <div class="title">
                <div class="txt-box">
                    <p>유료 회원 공인중개사를 위한</p>
                    <h3>이용가이드</h3>
                </div>
                <img src="/img/guide.jpg" class="guide-img">
            </div>
        <div class="main">
            <input id="tab1" type="radio" name="tabs" checked>
            <label for="tab1">회원가입</label>

            <input id="tab2" type="radio" name="tabs">
            <label for="tab2">매물찾기</label>

            <input id="tab3" type="radio" name="tabs">
            <label for="tab3">유료결제</label>

<%--            <input id="tab4" type="radio" name="tabs">--%>
<%--            <label for="tab4">모바일 이용방법</label>--%>

            <section id="content1">
                <img src="/img/guide01.png" alt="아바 회원가입 이용가이드">
            </section>

            <section id="content2">
                <img src="/img/guide02.png" alt="아바 매물찾기 이용가이드">
            </section>

            <section id="content3">
                <img src="/img/guide03.png" alt="아바 유료결제 이용가이드">
            </section>

<%--            <section id="content4">--%>
<%--                <p>tab menu4의 내용</p>--%>
<%--            </section>--%>
        </div>
    </div>
</div>
</body>
</html>
