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
            <input type="text" placeholder="검색">
            <i class="fas fa-search" style="position: absolute; right: 15px; top: 25%"></i>
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
                <th width="2.5%">
                    <input type="checkbox">
                </th>
                <th width="7.5%">번호</th>
                <th width="20%">매물명</th>
                <th width="7.5%">호실</th>
                <th width="20%">매물유형/거래유형</th>
                <th width="10%">거래가</th>
                <th width="10%">매물상태</th>
                <th width="10%">등록일자</th>
                <th>&nbsp;</th>
            </tr>
            <tbody class="row" id="offers">
            <tr>
                <th colspan="9" class="aba">주인 데이터를 선택하세요 :)</th>
            </tr>
            </tbody>
        </table>
    </div>

</div>

<script src="/web-resources/js/paginator/user-paginator.js"></script>
<script>
    let pageHelper = new UserPaginator(5, $('#owners'));
    let offerHelper = new OfferPaginator(5, $('#offers'));

    $(document).ready(function () {
        let pageInfo = getAllUsers(1);

        pageHelper.setEndPage(pageInfo['pages']);
        pageHelper.bindOffersByOwner(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindOffersByOwner(page, getAllUsers(page));
        });
    });

    function onPrevOrNext() {
        // pageHelper.prevOrNext(pageParam, () => {
        //     let pageInfo = getOffersByPage(pageParam);
        //
        //     pageHelper.bindOffers(pageParam, pageInfo);
        //     pageHelper.pageCalculation(pageParam, pageInfo, (page) => {
        //         pageHelper.bindOffers(page, getOffersByPage(page))
        //     });
        // })
    }

    function foldTrigger(focus) {
        onChecked(focus);

        let targetId = focus.siblings('.userId').text();
        let offers;

        if (focus.parents('tr').hasClass('checked')) {
            focus.find('img').attr('src', '/web-resources/img/basic/keyboard_arrow_down-24px.svg');

            offers = getOffers(targetId);
            offerHelper.bindOffers()
        } else {
            focus.find('img').attr('src', '/web-resources/img/basic/keyboard_arrow_up-24px.svg');
        }
    }

    function bindOffersOfOwner() {

    }
</script>
