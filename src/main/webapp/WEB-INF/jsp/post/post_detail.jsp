<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <head>
        <title>공지사항 - 상세게시글</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/web-resources/css/post_detail.css">

        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>

        <style>
            .main-container {
                height: calc(100% - 70px);
            }
        </style>
    </head>

    <body>
    <div class="main-container">
            <!-- 공지사항 페이지 내용 -->
            <section id="notice-con">
                <article class="contents">
                    <!-- 공지사항 타이틀 -->
                   <header class="head">
                       <div class="line"></div>
                       <h2>공지사항</h2>
                   </header>
                    <!-- 공지사항 게시판 내용 -->
                    <section class="con-in">
                        <article class="in01">
                            <c:choose>
                                <c:when test="${post.postType.code eq 'NOTICE'}"><h4 class="aba"></c:when>
                                <c:otherwise><h4></c:otherwise>
                            </c:choose>
                                [${post.postType.value}]
                                <span style="float: right; padding-right: 3.5%; font-size: 1rem; color: #666 !important;">
                                    <i class="fas fa-eye"></i>
                                    ${post.hits}
                                </span>
                            </h4>
                            <h3>${post.title}</h3>
                            <p class="align-right">
                                ${fn:substring(post.createdAt, 2, 16)} 작성
                            </p>
                        </article>
                        <article class="in02 txt-md">
                            <pre>${post.contents}</pre>
                        </article>
                        <article class="back-btn">
                            <a href="/posts">
                                <img src="/web-resources/img/notice_back_btn.png">
                            </a>
                        </article>
                    </section>
                </article>
            </section>
        </div>

        <!-- footer -->
        <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
    </body>
</html>
