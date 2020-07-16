<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/component/navibar.css">
    <link rel="stylesheet" type="text/css" href="/scss/me/me.css">
    <link rel="stylesheet" type="text/css" href="/scss/component/form.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>
<body>
    <div class="main-container">
        <div class="container-wrap">
            <header class="content-header">
                <ul class="">
                    <li class="active"><a href="/users/me">마이아바</a></li>
                    <li class=""><a href="/users/me/payment">결제관리</a></li>
                    <li class=""><a href="/users/me/account">계정관리</a></li>
                    <li class=""><a href="">매물관리</a></li>
                </ul>
            </header>
            <div class="content-wrap">
                <c:choose>
                    <c:when test="${not empty view}">
                        <c:import url="${view}.jsp" />
                    </c:when>
                    <c:otherwise>
                        <c:import url="my_aba.jsp" />
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- footer -->
    <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</body>
</html>
