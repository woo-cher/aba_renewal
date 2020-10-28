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
            <th width="15%">2</th>
            <th>3</th>
            <th>4</th>
            <th>5</th>
            <th>6</th>
            <th>7</th>
        </tr>
        <tr class="row">
            <td>
                <input type="checkbox">
            </td>
            <td>a</td>
            <td>a</td>
            <td>a</td>
            <td>a</td>
            <td>a</td>
            <td>a</td>
        </tr>
        <tr>
            <td colspan="7">paging</td>
        </tr>
    </table>
</div>
