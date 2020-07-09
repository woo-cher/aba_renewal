<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>공지사항</title>

        <link rel="stylesheet" type="text/css" href="/css/post_detail.css">

        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
    </head>

    <body>
        <div id="wrap">
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
                            <h4>[인사말]</h4>
                            <h3>공인중개사를 위한 최고의 솔루션 "부동산매물 정보제공 업체"</h3>
                            <p>작성일 19-08-17</p>
                        </article>
                        <article class="in02">
                            <p>기존 : 2017년 9월 10일 24:00시<br>
                                변경 : 2017년 9월 20일 24:00시<br>
                                안녕하십니까. 아바 대표 입니다. 기존에 무료기간을 10일 제공해드렸지만,<br>
                                많은 공인중개사분들이 회원가입 해주셔서 감사 이벤트로 기간을 10일 연장합니다<br>
                                참고 부탁드리겠습니다.<br>
                                -매매물건은 유료기간인 21일부터 매물 등록됩니다-</p>
                        </article>
                        <article class="back-btn">
                            <a href="/posts">
                                <img src="/img/notice_back_btn.png" alt="">
                            </a>
                        </article>
                    </section>
                </article>
            </section>

            <!-- footer -->
            <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
        </div>
    </body>
</html>
