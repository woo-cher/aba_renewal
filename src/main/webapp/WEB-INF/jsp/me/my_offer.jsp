<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
            <th width="25%">매물명</th>
            <th width="10%">호실</th>
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
                    <button class="fl" type="button" onclick="deleteCaller()">삭제</button>
                    <input type="hidden" class="target-id">
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

<script src="/web-resources/js/paginator/offer-paginator.js"></script>
<script>
    let pageHelper = new OfferPaginator(5, $('#my-offers'));
    let sessionUserId = '${sessionUser.userId}';

    $(document).ready(function () {
        let pageInfo = getOffersByUserId(pageHelper.startPage, sessionUserId);

        pageHelper.setEndPage(pageInfo['pages']);
        pageHelper.bindOffers(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindOffers(page, getOffersByUserId(page, sessionUserId));
        });

        $("#offer-count").text(pageInfo['total']);
    });

    function onPrevOrNext(pageParam) {
        pageHelper.prevOrNext(pageParam, () => {
            let pageInfo = getOffersByUserId(pageParam, sessionUserId);

            pageHelper.bindOffers(pageParam, pageInfo);
            pageHelper.pageCalculation(pageParam, pageInfo, (page) => {
                pageHelper.bindOffers(page, getOffersByUserId(page, sessionUserId))
            });
        })
    }

    function deleteCaller() {
        let offerId = $('.target-id').val();
        let removedTarget = $('.offer' + offerId).parent('tr');

        pageHelper.deleteOffer(offerId, removedTarget);
    }
</script>
