<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>Access denied</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
    </head>

    <body style="overflow: hidden">
        <div class="main-container pt-3" style="box-sizing: border-box; height: calc(100% - 370px)">
            <div class="align-center" style="line-height: 8vh;">
                <img src="/web-resources/img/character.png">
                <h1 class="aba pt-1">요청 페이지에 권한이 없어요 :(</h1>
                <h2>관리자에게 문의 해주세요!</h2>
            </div>
        </div>

        <!-- footer -->
        <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
    </body>
</html>
