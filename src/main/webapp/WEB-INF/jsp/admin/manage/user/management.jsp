<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>관리자 매물관리</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/navibar.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/table.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/paginator.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/admin/admin.css">

    <script src="/web-resources/js/page-helper.js"></script>

    <%@include file="/WEB-INF/jsp/commons/admin_header.jspf"%>
</head>

<body>
    <div class="main-container p-0 w-full in-flex">
        <div class="full-left-box">
            <header class="left-header aba">회원관리</header>
            <ul id="navigator" class="left-nav nav-bar-col">
                <li class="users" onclick="nav('')">회원 통합 관리</li>
                <li class="" onclick="nav('')">SUB 2</li>
                <li class="" onclick="nav('')">SUB 3</li>
                <li class="" onclick="nav('')">SUB 4</li>
                <li class="" onclick="nav('')">SUB 5</li>
            </ul>
        </div>
        <div class="full-right-box">
            <c:if test="${not empty view}">
                <c:import url="${view}.jsp" />
            </c:if>
        </div>
    </div>
</body>
</html>

<script>
    function nav(url) {
        location.href = "/admin/manage/users" + url;
    }

    function pageNavigator() {

    }

    activateWithSelector('#navigator > li');
    activateWithUrl(/.+\//g);
</script>
