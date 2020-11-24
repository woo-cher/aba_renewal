<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>마이페이지</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/navibar.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/me/me.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/paginator.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/table.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/dialog.css">

    <script src="/web-resources/js/page-helper.js"></script>

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>

<body>
    <div class="main-container pt-3">
        <div class="container-wrap">
            <header class="content-header">
                <ul id="navigator">
<%--                    <li class="my_aba" onclick="nav('my_aba')"><a>마이아바</a></li>--%>
<%--                    <li class="payment" onclick="nav('payment')"><a>결제관리</a></li>--%>
                    <li class="my_offer" onclick="nav('my_offer')"><a>내가 등록한 매물</a></li>
                    <li class="account" onclick="nav('account')"><a>계정관리</a></li>
                </ul>
            </header>
            <div class="content-wrap dialog-yardstick">
                <c:import url="${view}.jsp" />
            </div>
        </div>
    </div>

    <!-- footer -->
    <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</body>
</html>

<script>
    function nav(url) {
        location.href = "/users/me/" + url;
    }

    activateWithSelector('#nav > li');
    activateWithSelector('#navigator > li');
    // activateWithUrl(/.+\//g, () => { return "usersmemyaba"});
    activateWithUrl(/.+\//g);
    switchContentViewWithIndex('#nav > li', '.right-wrap', '.content-right');
</script>
