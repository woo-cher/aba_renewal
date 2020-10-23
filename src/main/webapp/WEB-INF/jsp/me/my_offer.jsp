<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" type="text/css" href="/web-resources/scss/component/table.css">

<div class="content-right p-3 w-full">
    <div class="content label pt-0 mt-0 b-0">
        <div class="label-wrap">[USER] 님이 등록한 매물</div>
    </div>
    <table class="admin-list-table">
    <tr class="table-top">
        <th width="2.5%">
            <input type="checkbox">
        </th>
        <th width="20%">매물명</th>
        <th width="15%">매물유형/거래유형</th>
        <th width="10%">거래가</th>
        <th width="10%">매물상태</th>
        <th width="10%">등록일자</th>
        <th>&nbsp;</th>
    </tr>
    <tbody class="row">
        <tr>
            <td>
                <input type="checkbox" class="checkbox" id="" onclick="onChecked($(this))">
            </td>
            <td>경남 진주시 아바빌 123-1</td>
            <td class="aba">원룸 / 월세</td>
            <td class="aba">500/30 + 3</td>
            <td class="aba">진행중</td>
            <td>20.10.23</td>
            <td width="20%">
                        <span class="border-side">
                            <i class="fas fa-eye" onclick="" title="매물 상세보기"></i>
                            <i class="fas fa-pen" title="매물 수정하기"></i>
                            <i class="fas fa-trash-alt" title="매물 삭제하기"></i>
                        </span>
            </td>
        </tr>
    </tbody>
    <tr>
        <td colspan="9">
            <div class="paginator b-0 p-0">
                <div class="page-wrap f-c">
                    <button class="page prev p-0" onclick="onPrevOrNext(pageHelper.startPage - 5)">
                        <img src="/web-resources/img/basic/keyboard_arrow_left-24px.svg">
                    </button>
                    <ul class="pages" style="display: contents;">
                        <li class="p-3">1</li>
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
    function onChecked(focus) {
        let target = focus.parents('tr');
        target.hasClass('checked') ? target.removeClass('checked') : target.addClass('checked')
    }
</script>
