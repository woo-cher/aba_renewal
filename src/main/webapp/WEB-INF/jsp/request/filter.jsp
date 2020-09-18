<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="filter-bar pt-3">
    <ul class="filter-group">
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-home fa-sm"></i>
                주거
            </a>
            <div class="filter-detail">
                <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                    <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
                </div>

                <div class="detail-container request">
                    <header class="detail-header">
                        <p class="title">주거유형</p>
                        <p class="caption">중복선택이 가능해요 ;)</p>
                    </header>

                    <ul class="checkbox-container" id="requestType" style="font-size: 0.9rem;">
                        <c:if test="${not empty requestTypes}">
                            <c:forEach var="requestType" items="${requestTypes}" begin="1" varStatus="vs">
                                <li class="checkbox-list">
                                    <input id="requestType${vs.index}" type="checkbox" name="requestType" value="${requestType}" class="check">
                                    <label for="requestType${vs.index}" onclick="updateDtoModel($(this).prev())">
                                            ${requestType.value}
                                    </label>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
            </div>
        </li>

        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-handshake fa-sm"></i>
                거래
            </a>
            <div class="filter-detail">
                <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                    <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
                </div>

                <div class="detail-container request">
                    <header class="detail-header">
                        <p class="title">거래유형</p>
                        <p class="caption">중복선택이 가능해요 ;)</p>
                    </header>

                    <ul class="checkbox-container flex-center" id="dealType">
                        <c:if test="${not empty dealTypes}">
                            <c:forEach var="dealType" items="${dealTypes}" begin="1" varStatus="vs">
                                <li class="checkbox-list">
                                    <input id="dealType${vs.index}" type="checkbox" name="dealType" value="${dealType}" class="check">
                                    <label for="dealType${vs.index}" onclick="updateDtoModel($(this).prev())">
                                            ${dealType.value}
                                    </label>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
            </div>
        </li>

        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-door-open"></i>
                방갯수
            </a>
            <div class="filter-detail">
                <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                    <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
                </div>

                <div class="detail-container request">
                    <header class="detail-header">
                        <p class="title">방갯수</p>
                        <p class="caption">중복선택이 가능해요 ;)</p>
                    </header>

                    <ul class="checkbox-container flex-center" id="room" style="font-size: .8rem;">
                        <c:forEach var="dealType" begin="1" end="4" varStatus="vs">
                            <li class="checkbox-list">
                                <input id="room${vs.index}" type="checkbox" name="room" value="${vs.index}" class="check">
                                <label for="room${vs.index}" onclick="updateDtoModel($(this).prev())">
                                        ${vs.index}개 이상
                                </label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </li>

        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-people-carry"></i>
                입주일
            </a>
            <div class="filter-detail">
                <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                    <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
                </div>

                <div class="detail-container request">
                    <header class="detail-header">
                        <p class="title">입주일</p>
                        <p class="caption">중복선택이 가능해요 ;)</p>
                    </header>

                    <ul class="checkbox-container flex-center" id="moveIn" style="font-size: .8rem;">
                        <c:forEach begin="${month}" end="${month + 3}" varStatus="vs">
                            <li class="checkbox-list">
                                <input id="moveIn${vs.index}" type="checkbox" name="moveIn" value="${vs.index}" class="check">
                                <label for="moveIn${vs.index}" onclick="updateDtoModel($(this).prev())">
                                        ${vs.index}월중
                                </label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </li>
    </ul>
</div>
