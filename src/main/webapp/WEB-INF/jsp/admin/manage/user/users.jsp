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
