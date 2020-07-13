<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="offer-list">
    <div class="list-header">
        전체 방
        <strong>&nbsp;1234개</strong>
    </div>
    <ul class="list-container">
        <c:forEach var="item" begin="0" end="10">
        <li class="list-item">
            <div class="offer-like">
                <img src="/img/offer/detail_head_icon-01.png">
            </div>
            <div class="offer">
                <div class="offer-thumbs">
                    <img src="/img/offer/detail_slide01.jpg">
                </div>
                <p class="offer-deal">
                    <label>월세</label>
                    <strong>200/35 +0</strong>
                    <label class="r-float">확인일자 YY-MM-DD</label>
                </p>
                <p class="offer-addr">진주시 상대동 202-50 화이트원룸</p>
                <div class="offer-summary">
                    <strong>원룸 | 201호 | 도시가스</strong>
                </div>
                <div class="label-info">
                    <label>세입자O</label>
                    <label>심야전기</label>
                    <label>방(전화)</label>
                </div>
                <p class="offer-tel">
                    <i class="fas fa-phone-square-alt"></i>
                    &nbsp;010-1243-1234
                </p>
            </div>
        </li>
        </c:forEach>
    </ul>
    <div class="paginator">
        <div class="page-wrap">
            <button class="page prev">
                <img src="/img/basic/keyboard_arrow_left-24px.svg">
            </button>
            <ul style="display: contents;">
                <li class="active"><h6>1</h6></li>
                <li><h5>2</h5></li>
                <li><h5>3</h5></li>
                <li><h5>4</h5></li>
                <li><h5>5</h5></li>
            </ul>
            <button class="page prev">
                <img src="/img/basic/keyboard_arrow_right-24px.svg">
            </button>
        </div>
    </div>
</div>
