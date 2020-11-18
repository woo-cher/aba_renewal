<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${isUpdate}">
        <c:set var="actionUrl" value="/posts/update" />
        <c:set var="action" value="수정" />
    </c:when>
    <c:otherwise>
        <c:set var="actionUrl" value="/posts/create" />
        <c:set var="action" value="등록" />
    </c:otherwise>
</c:choose>

<html>
<head>
    <title>공지사항</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/css/post_detail.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf" %>
</head>

<body>
<div class="main-container pt-3 over-hide">
    <!-- 공지사항 페이지 내용 -->
    <section id="notice-con">
        <article class="contents">
            <!-- 공지사항 타이틀 -->
            <header class="head">
                <div class="line mb-1"></div>
                <h2 class="p-3">게시글 ${message}</h2>
            </header>

            <div class="form-warp con-in p-0">
                <form action="${actionUrl}" method="post">
                    <c:if test="${isUpdate}">
                        <input type="hidden" name="id" value="${post.id}">
                    </c:if>
                    <div class="w-full form-control p-1 check-area">
                        <div class="form-label pl-0">* 유형</div>
                        <select class="p-1" name="postType" onchange="test($(this))">
                            <option value="NOTICE">공지사항</option>
                            <option value="NORMAL">일반게시물</option>
                        </select>
                    </div>
                    <article class="in01 p-1 form-control mt-0 check-area">
                        <%--                            <div class="form-label pb-1">* 제목</div>--%>
                        <div class="error-box"></div>
                        <input class="w-full pb-1 m-0" type="text" name="title" placeholder="게시글 제목" value="${post.title}">
                    </article>
                    <article class="in02 w-full p-1 form-control check-area">
                        <%--                            <div class="form-label">* 내용</div>--%>
                        <div class="error-box"></div>
                        <textarea class="w-full" id="contents" name="contents" placeholder="게시글 내용">${post.contents}</textarea>
                    </article>
                    <div class="form-control">
                        <button type="button" onclick="location.href = '/posts'" class="w-25 fl">이전</button>
                        <button type="submit" class="w-25 fr">${message}하기</button>
                    </div>
                </form>
            </div>
        </article>
    </section>
</div>
</body>
</html>

<style>
    .main-container {
        height: calc(100% - 71px);"
    }

    #contents {
        resize: none;
        height: 250px;
        padding: 2%;
        border-radius: 10px;
    }

    .error-box {
        right: 14% !important;
    }
</style>

<script>
    $(document).ready(function () {
        <c:if test="${not empty errors}">
        $('.error').remove();
        let fieldName, errorMessage, selector;

        <c:forEach var="error" items="${errors}">
        fieldName = `${error.getField()}`;
        errorMessage = `${error.getDefaultMessage()}`;

        selector = $('[name="' + fieldName + '"]').parents('.check-area');
        selector.addClass('invalid b-1r');
        selector.find('.error-box').append(
            '<p class="error" style="margin-bottom: 2px;">' +
            '<i class="fas fa-exclamation-circle">' +
            '</i>' + errorMessage + '</p>'
        );
        </c:forEach>
        </c:if>
    });
</script>
