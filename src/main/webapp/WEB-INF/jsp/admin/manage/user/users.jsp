<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="right-header">
    <header>
        회원통합관리
        <i class="fas fa-users"></i>
        <span class="mini-header">전체 회원들을 통합으로 관리합니다.</span>
    </header>
    <div class="btn-group">
        <button class="aba reverse" type="button">
            <i class="fas fa-user-plus"></i>
            계정 생성
        </button>
        <button class="aba" type="button">
            <i class="fas fa-align-justify"></i>
            사용자 필터
        </button>
        <span class="relative">
            <input type="text" id="keyword" placeholder="검색" onkeypress="checkPressedKey(event)">
            <i class="fas fa-search search" onclick="doSearch()"></i>
        </span>
    </div>
</div>
<div class="right-content">
    <table class="admin-list-table">
        <tr class="table-top">
            <th width="2.5%">
                <input type="checkbox">
            </th>
            <th width="15%">아이디</th>
            <th width="10%">이름</th>
            <th width="10%">닉네임</th>
            <th>연락처</th>
            <th>이메일</th>
            <th width="10%">회원유형</th>
            <th width="10%">권한</th>
            <th width="15%">&nbsp;</th>
        </tr>
        <tbody class="row" id="users">
            <div class="aba-dialog" id="user-dialog" title="아바" hidden>
                <div class="dialog-ask">
                    <p class="aba target"></p>
                    <p>을 삭제할까요?</p>
                </div>
                <div class="dialog-btn-group pt-3">
                    <button class="fl w-45" type="button" onclick="doDelete()">삭제</button>
                    <input type="hidden" class="target-id">
                    <button class="fr w-45" type="button" onclick="dialogCloseTrigger($('#user-dialog'))">취소</button>
                </div>
            </div>
        </tbody>
        <tr>
            <td colspan="9">
                <div class="paginator f-c b-0 p-0">
                    <div class="page-wrap">
                        <button class="page prev p-0" onclick="onPrevOrNext(pageHelper.startPage - 5)">
                            <img src="/web-resources/img/basic/keyboard_arrow_left-24px.svg">
                        </button>
                        <ul class="pages" style="display: contents;"></ul>
                        <button class="page prev p-0" onclick="onPrevOrNext(pageHelper.startPage + 5)">
                            <img src="/web-resources/img/basic/keyboard_arrow_right-24px.svg">
                        </button>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>

<script src="/web-resources/js/paginator/user-paginator.js"></script>
<script>
    let pageHelper = new UserPaginator(5, $('#users'));

    $(document).ready(function () {
        let pageInfo = getUsersExceptAdmin(pageHelper.startPage);
        pageHelper.bindUsers(1, pageInfo);
        pageHelper.setEndPage(pageInfo['pages']);

        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindUsers(page, getUsersExceptAdmin(page))
        });
    });

    function onPrevOrNext(pageParam) {
        pageHelper.prevOrNext(pageParam, () => {
            let pageInfo = getUsersExceptAdmin(pageParam);

            pageHelper.bindUsers(pageParam, pageInfo);
            pageHelper.pageCalculation(pageParam, pageInfo, (page) => {
                pageHelper.bindUsers(page, getUsersExceptAdmin(page))
            });
        })
    }

    function doDelete() {
        let userId = $('.target-id').val();
        let removedTarget = $('#' + userId);

        UserPaginator.deleteUser(userId, removedTarget);
    }

    function doSearch() {
        let keyword = $('#keyword').val();
        let pageInfo = searchUser(keyword, 1);

        pageHelper.bindUsers(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindUsers(page, searchUser(keyword, page))
        })
    }

    function checkPressedKey(e) {
        if (isEnterKey(e)) {
            doSearch();
        }
    }
</script>
