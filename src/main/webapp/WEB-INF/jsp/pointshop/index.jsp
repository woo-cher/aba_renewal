<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>아바 포인트샵</title>

    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.1/css/all.css" crossorigin="anonymous">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/pointshop.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/table.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf" %>
</head>

<style>
    .payment-list > li {
        align-items: center;
        text-align: center;
    }

    .payment-list span {
        width: 25% !important;
    }
</style>

<div class="main-container">
    <div class="content-area">
        <div class="header">
            <div class="box_in">
                <img class="fl mr-3" src="/web-resources/img/aboutus_con1_img.png" alt="">
                <p class="txt-lg">
                    발로 뛰는건 <span class="aba">아바</span>가 하고, 손을 쓰는건 <span class="aba">중개사</span>님이 하세요 :)
                </p>
            </div>
        </div>

        <div class="point-box">
            <div class="aba left">
                <span class="txt-md">보유 포인트</span>
                <i class="plus-icon fas fa-plus"
                   onclick="window.open('/payment', 'gi', 'width=900, height=700, top=200, left=500, status=no, scrollbars=no')"
                >
                </i>
            </div>
            <div class="right">
                <span class="price txt-md">5,000</span>
                <i class="p-icon txt-sm fas fa-ruble-sign"></i>
            </div>
        </div>

        <div class="package w-full">
            <table class="admin-list-table w-full">
                <tr class="table-top">
                    <th width="15%">선택</th>
                    <th width="15%">패키지명</th>
                    <th width="15%">가격</th>
                    <th>설명</th>
                </tr>
                <tr>
                    <td>
                        <input type="radio" name="a">
                    </td>
                    <td>유료보기 30일</td>
                    <td>
                        <span class="aba mr-3">300,000</span>
                        <i class="p-icon txt-sm fas fa-ruble-sign"></i>
                    </td>
                    <td><span class="aba">30일</span> 동안 등록된 모든 매물의 상세정보 열람 가능한 상품입니다.</td>
                </tr>
                <tr>
                    <td>
                        <input type="radio" name="a">
                    </td>
                    <td>유료보기 7일</td>
                    <td>
                        <span class="aba mr-3">75,000</span>
                        <i class="p-icon txt-sm fas fa-ruble-sign"></i>
                    </td>
                    <td><span class="aba">7일</span> 동안 등록된 모든 매물의 상세정보 열람 가능한 상품입니다.</td>
                </tr>
                <tr>
                    <td>
                        <input type="radio" name="a">
                    </td>
                    <td>유료보기 1일권</td>
                    <td>
                        <span class="aba mr-3">3,000</span>
                        <i class="p-icon txt-sm fas fa-ruble-sign"></i>
                    </td>
                    <td><span class="aba">1일</span> 동안 등록된 모든 매물의 상세정보 열람 가능한 상품입니다.</td>
                </tr>
            </table>
        </div>

        <button class="aba reverse charge-btn" type="button">구매하기</button>
    </div>
</div>
