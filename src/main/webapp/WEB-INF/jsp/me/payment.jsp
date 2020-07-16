<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <link rel="stylesheet" type="text/css" href="/scss/me/payment.css">
</head>

<div class="content-left">
    <div class="panel left-wrap">
        <ul class="nav-bar-col">
            <li class="txt-md">My *</li>
            <li class="txt-md">사용내역 조회</li>
            <li class="txt-md">결제이력 조회</li>
        </ul>
    </div>
</div>
<div class="content-right">
    <div id="my" class="panel pt-1 right-wrap">
        <div class="box">
            <div class="content label">
                <div class="label-wrap">
                    내 포인트
                </div>
            </div>
            <div class="content box point-box">
                <div class="box-left">
                    <span class="aba txt-lg">아바 포인트</span></div>
                <div class="box-right">
                    <span class="point txt-xl">1,000</span>
                    <i class="aba fas fa-ruble-sign"></i>
                </div>
            </div>
            <div class="align-right">
                <button class="btn sm inline" type="submit">충전하기</button>
            </div>
        </div>
        <div class="content label">
            <div class="label-wrap">
                이용중인 상품
            </div>
        </div>
        <ul class="payment-list">
            <li>
                <span class="title">상품명</span>
                <span class="title">상품가격</span>
                <span class="title">결제일</span>
                <span class="title">종료일</span>
                <span class="title">상세</span>
            </li>
            <li>
                <span class="aba">`유료보기 30일`</span>
                <span>12,000
                    <i class="aba point-label fas fa-ruble-sign"></i>
                </span>
                <span>2012.01.12</span>
                <span>2012.02.13</span>
                <button class="txt-sm" type="submit">상세보기</button>
            </li>
            <li class="expired">
                <span class="aba">`무료보기 30일`</span>
                <span>12,000
                    <i class="aba point-label fas fa-ruble-sign"></i>
                </span>
                <span>2012.01.12</span>
                <span>2012.02.13</span>
                <button class="txt-sm repay" type="submit">연장하기</button>
            </li>
        </ul>
    </div>
</div>
