<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .filter-group {
        font-size: .8rem !important; padding: 0 !important;
    }

    .detail-container { padding: 25px 15px 0 !important; }
</style>

<div class="right-header">
    <header>
        매물통합관리
        <i class="fas fa-tasks"></i>
        <span class="mini-header">모든 매물들을 통합으로 관리합니다.</span>
    </header>
    <div class="btn-group">
        <button class="aba reverse" type="button" onclick="window.open('/offers/form')">
            <i class="fas fa-user-plus"></i>
            매물 추가
        </button>
        <button class="aba" type="button" onclick="$('.admin-filter').slideToggle()">
            <i class="fas fa-align-justify"></i>
            매물 필터
        </button>
        <span class="relative">
            <input type="text" id="keyword" placeholder="검색" onkeypress="checkPressedKey(event)">
            <i class="fas fa-search search" onclick="doSearch()"></i>
        </span>
    </div>

    <%-- filter --%>
    <%@include file="/WEB-INF/jsp/map/filter_bar.jsp"%>
</div>
<div class="right-content">
    <table class="admin-list-table">
        <tr class="table-top">
            <th width="10%">매물번호</th>
            <th width="20%">매물명</th>
            <th width="6%">호실</th>
            <th width="15%">매물유형/거래유형</th>
            <th width="10%">거래가</th>
            <th width="10%">매물상태</th>
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
        <tr>
            <td colspan="10">
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
<script src="/web-resources/js/paginator/offer-paginator.js"></script>
<script>
    let pageHelper = new OfferPaginator(5, $('#offers'));

    $(document).ready(function () {
        let pageInfo = getOffers(pageHelper.startPage);

        pageHelper.setEndPage(pageInfo['pages']);
        pageHelper.bindOffers(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindOffers(page, getOffers(page));
        });
    });

    function onPrevOrNext(pageParam) {
        let offerPageInfo = getOffersByFilter(pageParam);
        pageHelper.setEndPage(offerPageInfo['pages']);

        pageHelper.prevOrNext(pageParam, () => {
            // Do return filters offer;
            pageHelper.bindOffers(pageParam, offerPageInfo);
            pageHelper.pageCalculation(pageParam, offerPageInfo, (page) => {
                pageHelper.bindOffers(page, getOffersByFilter(page))
            });
        })
    }

    function doDelete() {
        let offerId = $('.target-id').val();
        let removedTarget = $('.offer' + offerId).parent('tr');

        pageHelper.deleteOffer(offerId, removedTarget);
    }

    function doSearch() {
        let keyword = $('#keyword').val();
        let pageInfo = searchOffer(keyword, 1);

        pageHelper.bindOffers(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindOffers(page, searchOffer(keyword, page))
        });
    }

    function checkPressedKey(e) {
        if (isEnterKey(e)) {
            doSearch();
        }
    }
</script>
