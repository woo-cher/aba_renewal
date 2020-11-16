<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>게시글 등록</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/css/post_detail.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>

<body>
    <div class="main-container over-hide" style="height: calc(100% - 71px);">
        <!-- 공지사항 페이지 내용 -->
        <section id="notice-con">
            <article class="contents">
                <!-- 공지사항 타이틀 -->
                <header class="head">
                    <div class="line"></div>
                    <h2 class="p-3">게시글 등록</h2>
                </header>

                <div class="form-warp con-in">
                    <form action="/posts/create" method="post">
                        <article class="in01 p-0 pb-3 form-control mt-0">
                            <div class="form-label pb-1">* 제목</div>
                            <input class="w-full pb-1" type="text" name="title" value="공인중개사를 위한 최고의 솔루션 부동산매물 정보제공 업체">
                        </article>
                        <article class="in02 w-full p-0 form-control">
                            <div class="form-label">* 내용</div>
                            <textarea class="w-full" name="demand" style="resize: none; height: 250px; padding: 2%; border-radius: 10px;"></textarea>
                        </article>
                        <div class="form-control">
                            <button type="submit" onclick="return false" class="w-25 fl">이전</button>
                            <button type="submit" class="w-25 fr">등록하기</button>
                        </div>
                    </form>
                </div>
            </article>
        </section>
    </div>
</body>
</html>
