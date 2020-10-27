<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" type="text/css" href="/web-resources/scss/component/table.css">
<link rel="stylesheet" type="text/css" href="/web-resources/scss/component/dialog.css">

<div class="content-right p-3 w-full">
    <div class="overlay" style="background: black;" hidden></div>
    <div class="content label pt-0 mt-0 b-0">
        <div class="label-wrap">
            [<span class="aba p-1">${sessionUser.name}</span>]
            &nbsp;님이 등록한 매물은 총&nbsp;
            <span class="aba p-1" id="offer-count">?</span> 건 입니다.
        </div>
    </div>
    <table class="admin-list-table">
    <tr class="table-top">
        <th width="2.5%">
            <input type="checkbox">
        </th>
        <th width="20%">매물명</th>
        <th width="5%">호실</th>
        <th width="15%">매물유형/거래유형</th>
        <th width="10%">거래가</th>
        <th width="10%">매물상태</th>
        <th width="10%">등록일자</th>
        <th>&nbsp;</th>
    </tr>
    <tbody class="row" id="my-offers">
        <div class="aba-dialog" id="offer-dialog" title="아바" hidden>
            <div class="dialog-ask">
                <p class="aba" id="target"></p>
                <p>을 삭제할까요?</p>
            </div>
            <div class="dialog-btn-group pt-3">
                <button class="fl" type="button" onclick="deleteOffer()">삭제</button>
                <input type="hidden" id="target-id">
                <button class="fr" type="button" onclick="dialogCloseTrigger($('#offer-dialog'))">취소</button>
            </div>
        </div>
    </tbody>
    <tr>
        <td colspan="9">
            <div class="paginator b-0 p-0">
                <div class="page-wrap f-c">
                    <button class="page prev p-0" onclick="onPrevOrNext(pageHelper.startPage - 5)">
                        <img src="/web-resources/img/basic/keyboard_arrow_left-24px.svg">
                    </button>
                    <ul class="pages" style="display: contents;">
                        <li class="active">1</li>
                    </ul>
                    <button class="page prev p-0" onclick="onPrevOrNext(pageHelper.startPage + 5)">
                        <img src="/web-resources/img/basic/keyboard_arrow_right-24px.svg">
                    </button>
                </div>
            </div>
        </td>
    </tr>
</table>
</div>

<script>
    let pageHelper = new PageHelper(5);
    let sessionUserId = '${sessionUser.userId}';

    $(document).ready(function () {
        let pageInfo = getOffersByUserId(pageHelper.startPage, sessionUserId);

        bindOffers($('#my-offers'), 1, pageInfo);

        $("#offer-count").text(pageInfo['total']);

        pageHelper.setEndPage(pageInfo['pages']);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            bindOffers($('#my-offers'), page, getOffersByUserId(page, sessionUserId));
        });
    });

    function onPrevOrNext(pageParam) {
        pageHelper.prevOrNext(pageParam, () => {
            let pageInfo = getOffersByUserId(pageParam, sessionUserId);

            bindOffers($('#users'), pageParam, pageInfo);

            pageHelper.pageCalculation(pageParam, pageInfo, (page) => {
                bindOffers($('#users'), page, getOffersByUserId(page, sessionUserId))
            });
        })
    }

    function deleteOffer() {
        let offerId = $('#target-id').val();

        if(deleteOfferById(offerId) === 1) {
            $('.offer' + offerId).parent('tr').remove();
            dialogCloseTrigger($('#offer-dialog'));
        }
    }

    function bindOffers(where, page, pageInfo) {
        let offers = pageInfo['list'];
        let count = 0;

        where.empty();

        for(let i = 0; i < offers.length; i++) {
            let offer = offers[i];
            let offerId = offer.id;

            where.append(`
                <tr>
                    <td>
                        <input type="checkbox" class="checkbox" id="${'${offerId}'}" onclick="onChecked($(this))">
                    </td>
                    <td class="offer${'${offer.id}'}">${'${offer.offerAddress.jibun}'} ${'${offer.offerAddress.buildingName}'} </td>
                    <td>${'${offer.offerAddress.ho}'}</td>
                    <td>${'${offer.type.value}'} / ${'${offer.dealType.value}'}</td>
                    <td>
                        <span>${'${offer.deposit}'}/${'${offer.monthlyPrice}'} +</span>
                        <span class="aba"> ${'${offer.managementPrice}'}</span>
                    </td>
                    <td class="aba">${'${offer.status.value}'}</td>
                    <td>${'${offer.createdAt.slice(2, 10).replaceAll("-", ".")}'}</td>
                    <td width="20%">
                        <span class="border-side">
                            <i class="fas fa-eye" title="매물 상세보기" onclick="window.open('/offers/${'${offerId}'}')" ></i>
                            <i class="fas fa-pen" title="매물 수정하기" onclick="alert('준비중입니다 :(')"></i>
                            <i class="fas fa-trash-alt" title="매물 삭제하기"
                               onclick="dialogInitializer($(this), $('#offer-dialog'), $('.offer${'${offerId}'}', ).text(), ${'${offerId}'})"
                            >
                            </i>
                        </span>
                    </td>
                </tr>
            `)
        }
    }

    function onChecked(focus) {
        let target = focus.parents('tr');
        target.hasClass('checked') ? target.removeClass('checked') : target.addClass('checked')
    }
</script>
