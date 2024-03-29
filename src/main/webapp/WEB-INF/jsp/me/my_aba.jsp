<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/me/my_aba.css">
</head>

<div class="content-left">
    <div class="panel left-wrap">
        <div class="content user-box">
            <div class="frame avatar">
                <img class="" src="/web-resources/img/guide.jpg">
                <p class="content">
                    <span class="txt-lg">${sessionUser.nickName}</span> 님
                </p>
                <p class="d-label">Diamond</p>
            </div>
            <div class="frame profile">
                <ul class="content">
                    <li class="content">
                        <span class="rank d-mark">D</span>
                        공인중개사
                    </li>
                </ul>
            </div>
        </div>
        <div class="content point-box">
            <div class="box-left">
                <span class="aba label">아바 포인트</span></div>
            <div class="box-right">
                <span class="point">
                    <fmt:formatNumber value="${sessionUser.point}" pattern="#,###" />
                </span>
                <i class="fas fa-ruble-sign"></i>
            </div>
        </div>
        <div>
            <button class="w-full" type="button"
                    onclick="window.open('/payment', 'gi', 'width=800, height=700, top=200, left=600, status=no, scrollbars=no')"
            >
                포인트 충전
            </button>
        </div>
    </div>
</div>

<div class="content-right">
    <div class="panel right-wrap">
        <ul class="content dashboard-box">
           <li class="b-r">
               <p class="content category">찜한 매물</p>
               <span class="aba content txt-lg">준비중</span>
           </li>
           <li class="b-r">
               <p class="content category">오늘 본 매물</p>
               <span class="aba content txt-lg">준비중</span>
           </li>
           <li class="b-r">
               <p class="content category">최근 본 매물</p>
               <span class="aba content txt-lg">준비중</span>
           </li>
           <li>
               <p class="content category">매물 신고</p>
               <span class="aba content txt-lg">준비중</span>
           </li>
        </ul>

        <div class="content activity-box">
            <div class="content label">
                <div class="label-wrap">나의 활동</div>
            </div>
            <ul class="activity">
                <li>
                    <p class="box-left p-0 w-full">
                        <span class="aba">`유료 매물 30일`</span>
                        상품을 결제 하셨습니다.
                    </p>
                    <p class="box-right">2012.01.12 오후 3시</p>
                </li>
                <li>
                    <p class="box-left p-0 w-full">
                        <span class="aba">'아바'</span> 님께 쪽지를 보내셨습니다.
                    </p>
                    <p class="box-right">2012.01.12 오후 3시</p>
                </li>
                <li class="none">
                    <p class="box-left w-full">
                        <span class="aba">활동</span>
                        을 시작해볼까요?! :)
                    </p>
                </li>
            </ul>
        </div>
    </div>
</div>
