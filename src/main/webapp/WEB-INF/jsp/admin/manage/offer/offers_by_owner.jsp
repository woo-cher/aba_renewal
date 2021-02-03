<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="right-header">
    <header>
        주인기준 통합관리
        <i class="fas fa-house-user"></i>
        <span class="mini-header">집주인의 연락처를 기준으로 한 매물들을 통합으로 관리합니다.</span>
    </header>
    <div class="btn-group">
        <button class="aba reverse" type="button" onclick="window.open('/offers/form')">
            <i class="fas fa-user-plus"></i>
            매물 추가
        </button>
        <button class="aba" type="button">
            <i class="fas fa-align-justify"></i>
            매물 필터
        </button>
        <span class="relative">
            <input type="text" id="keyword" placeholder="검색" onkeypress="checkPressedKey(event)">
            <i class="fas fa-search search" onclick="doSearch()"></i>
        </span>
    </div>
</div>
<div class="right-content flex">
    <div class="w-35 pt-1">
        <table class="admin-list-table">
            <tr class="table-top">
                <th></th>
                <th>아이디</th>
                <th>이름</th>
                <th>대표연락처</th>
                <th>회원유형</th>
            </tr>
            <tbody class="row" id="owners"></tbody>
            <tr>
                <td colspan="7">
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
    <div class="w-65 p-1">
            <table class="admin-list-table">
            <tr class="table-top">
                <th width="7.5%">번호</th>
                <th width="20%">매물명</th>
                <th width="7.5%">호실</th>
                <th width="">유형</th>
                <th width="12.5%">거래가</th>
                <th width="7.5%">상태</th>
                <th width="10%">등록일</th>
                <th>&nbsp;</th>
            </tr>
            <tbody class="row" id="offers">
                <div class="aba-dialog" id="offer-dialog" title="아바" hidden>
                    <div class="dialog-ask">
                        <p class="aba target"></p>
                        <p>을 삭제할까요?</p>
                    </div>
                    <div class="dialog-btn-group pt-3">
                        <button class="fl" type="button" onclick="doDelete()">삭제</button>
                        <input type="hidden" class="target-id">
                        <button class="fr" type="button" onclick="dialogCloseTrigger($('#offer-dialog'))">취소</button>
                    </div>
                </div>
                <%@include file="/WEB-INF/jsp/commons/dialog/offer-status.jsp"%>
            </tbody>
            <tr id="message">
                <th colspan="9" class="aba">주인 데이터를 선택하세요 :)</th>
            </tr>
        </table>
    </div>
</div>

<script src="/web-resources/js/paginator/user-paginator.js"></script>
<script src="/web-resources/js/paginator/offer-paginator.js"></script>
<script>
    let pageHelper = new UserPaginator(5, $('#owners'));
    let checkedEl;

    $(document).ready(function () {
        let pageInfo = getAllUsers(1);

        pageHelper.setEndPage(pageInfo['pages']);
        pageHelper.bindOffersByOwner(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindOffersByOwner(page, getAllUsers(page));
        });
    });

    function onPrevOrNext(pageParam) {
        pageHelper.prevOrNext(pageParam, () => {
            let pageInfo = getAllUsers(pageParam);

            pageHelper.bindOffersByOwner(pageParam, pageInfo);
            pageHelper.pageCalculation(pageParam, pageInfo, (page) => {
                pageHelper.bindOffersByOwner(page, getAllUsers(page))
            });
        })
    }

    function foldTrigger(focus) {
        if (checkedEl) {
            if (!$(checkedEl).is(focus)) {
                $(checkedEl).parents('tr').removeClass('checked');
                addUnCheckedAttr($(checkedEl));
            }
        }

        onChecked(focus);
        checkedEl = focus;

        let targetId = focus.siblings('.userId').text();
        let offers;

        if (focus.parents('tr').hasClass('checked')) {
            addCheckedAttr(focus);
            offers = getOffers(null, targetId);
            bindOffersOfOwner(targetId, offers);
        } else {
            addUnCheckedAttr(focus);
            $('#offers').empty();
            $('#message').show();
        }
    }

    function addCheckedAttr(focus) {
        focus.find('img').attr('src', '/web-resources/img/basic/keyboard_arrow_down-24px.svg');
    }

    function addUnCheckedAttr(focus) {
        focus.find('img').attr('src', '/web-resources/img/basic/keyboard_arrow_up-24px.svg');
    }

    function bindOffersOfOwner(user, offers) {
        let bindingArea = $('#offers');

        bindingArea.empty();
        $('#message').hide();

        if(offers.length === 0) {
            bindingArea.append(`<tr><th colspan="9"><span class="aba">${'${user}'}</span> 님이 가진 매물이 없네요 :(</th></tr>`);
            $('#message').hide();
            return
        }

        for(let i = 0; i < offers.length; i++) {
            let offer = offers[i];
            let offerId = offer.id;

            bindingArea.append(`
                <tr>
                    <td class="aba offer-id">${'${offer.id}'}</td>
                    <td class="offer${'${offer.id}'}">
                        ${'${offer.offerAddress.jibun}'} ${'${offer.offerAddress.buildingName !== null ? offer.offerAddress.buildingName : ""}'}
                    </td>
                    <td>${'${offer.offerAddress.ho !== null ? offer.offerAddress.ho : "정보없음"}'}</td>
                    <td>${'${offer.type.value}'} / ${'${offer.dealType.value}'}</td>
                    <td>
                        <span>${'${offer.deposit}'}/${'${offer.monthlyPrice}'} +</span>
                        <span class="aba"> ${'${offer.managementPrice}'}</span>
                    </td>
                    <td class="aba status" onclick="dialogInitializer($(this), $('#status-dialog'), null, ${'${offer.id}'})">${'${offer.status.value}'}</td>
                    <td>${'${offer.createdAt.slice(2, 10).replaceAll("-", ".")}'}</td>
                    <td onclick="event.cancelBubble=true">
                        <span class="border-side">
                            <i class="fas fa-eye" title="매물 상세보기" onclick="window.open('/offers/${'${offer.id}'}')" ></i>
                            <i class="fas fa-pen" title="매물 수정하기"
                                onclick="window.open('/offers/form?offerId=${'${offer.id}'}', '', 'width=1400, height=950, top=30, left=250')">
                            </i>
                            <i class="fas fa-trash-alt" title="매물 삭제하기"
                               onclick="dialogInitializer($('#offer-dialog'), $('.offer${'${offer.id}'}').text(), ${'${offer.id}'})"
                            >
                            </i>
                        </span>
                    </td>
                </tr>
            `)
        }
    }

    function doDelete() {
        let offerId = $('.target-id').val();
        let removedTarget = $('.offer' + offerId).parent('tr');

        OfferPaginator.deleteOffer(offerId, removedTarget);
    }

    function doSearch() {
        let keyword = $('#keyword').val();
        let pageInfo = searchUser(keyword, 1);

        pageHelper.bindOffersByOwner(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindOffersByOwner(page, searchUser(keyword, page))
        })
    }

    function checkPressedKey(e) {
        if (isEnterKey(e)) {
            doSearch();
        }
    }
</script>
