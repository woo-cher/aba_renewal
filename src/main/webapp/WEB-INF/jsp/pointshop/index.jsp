<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>아바 포인트샵</title>

    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/dialog.css">
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

<div class="main-container dialog-yardstick">
    <div class="overlay" hidden></div>
    <div class="loader" hidden></div>
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
                   onclick="window.open('/payment', 'gi', 'width=800, height=700, top=200, left=550, status=no, scrollbars=no')"
                >
                </i>
            </div>
            <div class="right">
                <span class="price txt-md"><fmt:formatNumber value="${sessionUser.point}" pattern="#,###" /></span>
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
                        <input type="radio" name="a" value="1">
                    </td>
                    <td class="name">유료보기 30일</td>
                    <td class="price">
                        <span class="aba mr-3">300,000</span>
                        <i class="p-icon txt-sm fas fa-ruble-sign"></i>
                    </td>
                    <td><span class="aba">30일</span> 동안 등록된 모든 매물의 상세정보 열람 가능한 상품입니다.</td>
                </tr>
                <tr>
                    <td>
                        <input type="radio" name="a" value="2">
                    </td>
                    <td class="name">유료보기 7일</td>
                    <td class="price">
                        <span class="aba mr-3">75,000</span>
                        <i class="p-icon txt-sm fas fa-ruble-sign"></i>
                    </td>
                    <td><span class="aba">7일</span> 동안 등록된 모든 매물의 상세정보 열람 가능한 상품입니다.</td>
                </tr>
                <tr>
                    <td>
                        <input type="radio" name="a" value="3">
                    </td>
                    <td class="name">유료보기 1일</td>
                    <td class="price">
                        <span class="aba mr-3">3,000</span>
                        <i class="p-icon txt-sm fas fa-ruble-sign"></i>
                    </td>
                    <td><span class="aba">1일</span> 동안 등록된 모든 매물의 상세정보 열람 가능한 상품입니다.</td>
                </tr>
            </table>
        </div>

        <button class="aba reverse charge-btn" type="button" onclick="beforePurchase()">구매하기</button>
    </div>

    <div class="aba-dialog" id="purchase-dialog" title="아바" hidden>
        <div class="dialog-ask">
            <p class="aba target"></p>
            <p>위 상품을 포인트로 구매할까요? :)</p>
            <input type="hidden" class="target_id">
        </div>
        <div class="dialog-ask">
            <p>
                보유 포인트 :
                <span class="aba" id="have">
                    <fmt:formatNumber value="${sessionUser.point}" pattern="#,###" />
                </span>
            </p>
            <p>
                필요 포인트 :
                <span class="aba" id="need"></span>
            </p>
        </div>
        <div class="dialog-btn-group pt-3">
            <button class="fl w-45" type="button" onclick="doPurchase()">구매</button>
            <input type="hidden" class="target-id">
            <button class="fr w-45" type="button" onclick="dialogCloseTrigger($('#purchase-dialog'))">취소</button>
        </div>
    </div>

    <div class="aba-dialog" id="msg-dialog" title="아바" hidden>
        <div class="dialog-ask">
            <p class="target"></p>
        </div>
        <div class="dialog-btn-group pt-3">
            <button class="w-45" type="button" onclick="dialogCloseTrigger($('#msg-dialog'))">확인</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        showLoader();
    });

    function beforePurchase() {
        let havePoint = Number('${sessionUser.point}');
        let selected = $('input[name="a"]:checked');

        if (selected.length === 0) {
            dialogInitializer($('#msg-dialog'), '상품을 선택하세요 :D', null);

            return;
        }

        let name = selected.parent().next('.name').text();
        let price = selected.parent().siblings('.price').children('span').text();

        if (havePoint < Number(price.replaceAll(',', ''))) {
            let message = `보유 포인트가 부족해요 :(`;
            dialogInitializer($('#msg-dialog'), message, null);

            return;
        }

        $('#need').text(price);
        dialogInitializer($('#purchase-dialog'), name, selected.val())
    }


    function doPurchase() {
        let packageId = $('.target-id').val();
        createMembership(packageId);

        showLoader();
        $('.ui-dialog').css('opacity', '.5');
        setTimeout(() => {
            if(!alert("패키지 구매를 완료했어요 :)")) {
                location.reload();
            }
        }, 500)
    }
</script>
