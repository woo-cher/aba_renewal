<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>의뢰목록</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/scss/post.css">

        <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
    </head>

    <body>
        <div class="main-container">
            <div class="post-header">
                <div class="title">
                    <div class="line"></div>
                    <h2>의뢰목록</h2>
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
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">등록일</th>
                            <th scope="col">조회</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="notice">[공지]</td>
                            <td>
                                <a href="/posts/1" class="td02">아바에서 일반인도 볼 수 있는 페이지가 베타 오픈했습니다..</a>
                            </td>
                            <td>2018.03.27</td>
                            <td>1314</td>
                        </tr>
                        <c:choose>
                            <c:when test="${not empty requests}">
                                <c:forEach var="req" items="${requests}" varStatus="vs">
                                <tr>
                                    <td>${req.id}</td>
                                    <td>
                                        <a href="#" class="td02">${req.title}</a>
                                    </td>
                                    <td>${fn:substring(req.createdAt, 0, 10)}</td>
                                    <td>${req.hits}</td>
                                </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <td colspan="4" class="aba">의뢰 목록이 없어요 :(</td>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

                <div class="page-num">
                    <a href="#" class="num" style="font-size:1.75rem; font-weight: 700;">
                        1
                    </a>
                </div>

            </section>
        </div>

    <!-- footer -->
    <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
    </body>
</html>
