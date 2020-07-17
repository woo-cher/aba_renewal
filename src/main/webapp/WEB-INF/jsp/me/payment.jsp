<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <link rel="stylesheet" type="text/css" href="/scss/me/payment.css">
</head>

<div class="content-left">
    <div class="panel left-wrap">
        <ul id="nav" class="nav-bar-col">
            <li class="txt-md active">My *</li>
            <li class="txt-md">포인트 내역 조회</li>
            <li class="txt-md">결제 내역 조회</li>
        </ul>
    </div>
</div>
<div class="content-right">
    <div class="panel pt-1 right-wrap">
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
                <span class="title">-</span>
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

    <div class="panel pt-1 right-wrap" hidden>
        <div class="box">
            <div class="content label">
                <div class="label-wrap">
                    포인트 사용 내역
                </div>
            </div>
            <ul class="payment-list">
                <li>
                    <span class="title">대상</span>
                    <span class="title">사용포인트</span>
                    <span class="title">사용일</span>
                    <span class="title">분류</span>
                    <span class="title">-</span>
                </li>
                <li>
                    <span class="aba">`유료보기 30일`</span>
                    <span>2,000
                        <i class="aba point-label fas fa-ruble-sign"></i>
                    </span>
                    <span>2012.01.12</span>
                    <span>패키지 구매</span>
                    <button class="txt-sm" type="submit">상세보기</button>
                </li>
                <c:forEach begin="0" end="4">
                    <li class="expired">
                        <span class="aba">`무료보기 30일`</span>
                        <span>0
                            <i class="aba point-label fas fa-ruble-sign"></i>
                        </span>
                        <span>2012.01.12</span>
                        <span>이벤트</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="panel pt-1 right-wrap" hidden>
        <div class="box">
            <div class="content label">
                <div class="label-wrap">
                    결제 내역
                </div>
            </div>
            <ul class="payment-list">
                <li>
                    <span class="title">결제상품명</span>
                    <span class="title">상품구성</span>
                    <span class="title">결제요청일</span>
                    <span class="title">처리결과</span>
                    <span class="title">-</span>
                </li>
                <li>
                    <span class="aba">`유료보기 30일`</span>
                    <span>2,000
                        <i class="aba point-label fas fa-ruble-sign"></i>
                    </span>
                    <span>2012.01.12</span>
                    <span class="failure">결제실패</span>
                    <span class="failure">시스템 오류로 요청이 반려됨</span>
                </li>
                <c:forEach begin="0" end="4">
                    <li class="expired">
                        <span class="aba">`무료보기 30일`</span>
                        <span>0
                            <i class="aba point-label fas fa-ruble-sign"></i>
                        </span>
                        <span>2012.01.12</span>
                        <span class="aba">정상승인</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<script>
    activateWithSelector($('#nav > li'));

    $('#nav > li').click(function () {
        let i = $('#nav > li').index(this);

        $('.right-wrap').hide();
        $('.content-right').children().eq(i).show();
    })
</script>
