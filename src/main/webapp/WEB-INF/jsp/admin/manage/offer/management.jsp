<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>관리자 매물관리</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/navibar.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/me/me.css">

    <%@include file="/WEB-INF/jsp/commons/admin_header.jspf"%>
</head>

<body>
    <div class="main-container pt-3">
        <div class="container-wrap">
            <header class="content-header">
                <ul id="navigator">
                    <li class="offers" onclick="nav('')"><a>매물 통합관리</a></li>
                    <li class="reports" onclick="nav('/reports')"><a>매물신고 내역</a></li>
                </ul>
            </header>
            <div class="content-wrap">
                <c:if test="${not empty view}">
                    <c:import url="${view}.jsp" />
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    function nav(url) {
        location.href = "/admin/manage/offers" + url;
    }

    activateWithSelector('#navigator > li');
    activateWithUrl(/.+\//g);
</script>
