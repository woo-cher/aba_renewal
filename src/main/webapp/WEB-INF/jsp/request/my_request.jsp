<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>나의 요청 매물</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

        <link rel="stylesheet" type="text/css" href="/web-resources/scss/post.css">

        <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
    </head>

    <body>
        <div class="main-container">
            <div class="post-header">
                <div class="title">
                    <div class="line"></div>
                    <h2>나의 요청 매물</h2>
                </div>
            </div>

            <!-- 표 -->
            <section id="table" class="pt-3">
                <table>
                    <colgroup>
                        <col style="width:100px">
                        <col>
                        <col style="width:140px">
                        <col style="width:110px">
                    </colgroup>
                    <thead>
                        <tr>
                            <th id="num" scope="col">번호</th>
                            <th id="title" scope="col">제목</th>
                            <th id="date" scope="col">등록일</th>
                            <th id="hit" scope="col">조회</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty requests}">
                                <c:forEach var="req" items="${requests}" varStatus="vs">
                                <tr>
                                    <td>${req.id}</td>
                                    <td>
                                        <a href="#" onclick="window.open('/requests/${req.id}')" class="td02">${req.demand}</a>
                                    </td>
                                    <td>${fn:substring(req.createdAt, 5, 10).replace("-", ".")}</td>
                                    <td>${req.hits}</td>
                                </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <td colspan="4" class="aba">요청 목록이 없어요 :(</td>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

<%--                <div class="page-num">--%>
<%--                    <a href="#" class="num" style="font-size:1.75rem; font-weight: 700;">--%>
<%--                        1--%>
<%--                    </a>--%>
<%--                </div>--%>

            </section>
        </div>
    </body>
</html>
