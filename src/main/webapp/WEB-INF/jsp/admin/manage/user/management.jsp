<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>관리자 매물관리</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/navibar.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/admin/admin.css">

    <%@include file="/WEB-INF/jsp/commons/admin_header.jspf"%>
</head>

<body>
    <div class="main-container p-0 w-full in-flex">
        <div class="full-left-box">
            <ul id="navigator" class="nav-bar-col">
                <li class="users" onclick="nav('')"><a>회원 통합관리</a></li>
                <li class="" onclick="nav('')"><a>SUB 2</a></li>
                <li class="" onclick="nav('')"><a>SUB 3</a></li>
                <li class="" onclick="nav('')"><a>SUB 4</a></li>
                <li class="" onclick="nav('')"><a>SUB 5</a></li>
            </ul>
        </div>
        <div class="full-right-box">
            <c:if test="${not empty view}">
                ${view}
            </c:if>
        </div>
    </div>
</body>
</html>

<script>
    function nav(url) {
        location.href = "/admin/manage/users" + url;
    }

    activateWithSelector('#navigator > li');
    activateWithUrl(/.+\//g);
</script>
