<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="right-header">
    <header>
        매물통합관리
        <i class="fas fa-tasks"></i>
        <span class="mini-header">모든 매물들을 통합으로 관리합니다.</span>
    </header>
    <div class="btn-group">
        <button class="aba reverse" type="button" onclick="window.open('/create/form')">
            <i class="fas fa-user-plus"></i>
            매물 추가
        </button>
        <button class="aba" type="button">
            <i class="fas fa-align-justify"></i>
            매물 필터
        </button>
        <span class="relative">
            <input type="text" placeholder="검색">
            <i class="fas fa-search" style="position: absolute; right: 15px; top: 25%"></i>
        </span>
    </div>
</div>
<div class="right-content">
    <table class="admin-list-table">
        <tr class="table-top">
            <th width="2.5%">
                <input type="checkbox">
            </th>
            <th width="10%">매물번호</th>
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
                <p class="aba target"></p>
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
    let pageHelper = new OfferPaginator(5, $('#my-offers'));

    $(document).ready(function () {
        let pageInfo = getOffers(pageHelper.startPage);

        pageHelper.setEndPage(pageInfo['pages']);
        pageHelper.bindOffers(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindOffers(page, getOffers(page));
        });
    });

    function onPrevOrNext(pageParam) {
        pageHelper.prevOrNext(pageParam, () => {
            let pageInfo = getOffers(pageParam);

            pageHelper.bindOffers(pageParam, pageInfo);
            pageHelper.pageCalculation(pageParam, pageInfo, (page) => {
                pageHelper.bindOffers(page, getOffers(page))
            });
        })
    }
</script>
