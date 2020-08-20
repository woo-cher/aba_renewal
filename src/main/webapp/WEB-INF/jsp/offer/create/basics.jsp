<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="form-control mt-0">
    <div class="form-warp">
        <div class="deal-type">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>거래유형</span>
            </div>
            <ul class="checkbox-container form type pt-1">
                <c:forEach begin="1" var="type" items="${dealTypes}" varStatus="vs">
                    <li class="checkbox-list">
                        <input id="dealType${vs.index}" type="radio" name="dealType" value="${type.code}" class="check">
                        <label for="dealType${vs.index}">${type.value}</label>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="offer-type">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>매물분류</span>
            </div>
            <ul class="checkbox-container form type pt-1">
                <c:forEach begin="1" var="type" items="${offerTypes}" varStatus="vs">
                    <li class="checkbox-list half">
                        <input id="offerType${vs.index}" type="radio" name="type" value="${type.code}" class="check">
                        <label for="offerType${vs.index}">${type.value}</label>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="heating-type">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>난방유형</span>
            </div>
            <ul class="checkbox-container form type pt-1">
                <c:forEach begin="1" var="type" items="${heatingTypes}" varStatus="vs">
                    <li class="checkbox-list half">
                        <input id="heatingType${vs.index}" type="radio" name="heatingType" value="${type.code}" class="check">
                        <label for="heatingType${vs.index}">${type.value}</label>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="offer-deal">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>매물가격 (보증금 / 달세 + 관리비)</span>
            </div>
            <div class="form-category full">
                <div class="input-group">
                    <input type="text" class="short" id="deposit" placeholder="보증금" name="deposit">
                    <p class="icon"><i class="fas">만</i></p>
                    <p class="short">/</p>
                    <input type="text" class="short" id="monthlyPrice" placeholder="달세" name="monthlyPrice">
                    <p class="icon"><i class="fas">만</i></p>
                    <p class="short">+</p>
                    <input type="text" class="short" id="managementPrice" placeholder="관리비" name="managementPrice">
                    <p class="icon"><i class="fas">만</i></p>
                </div>
            </div>
        </div>

        <div class="year pt-3">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>준공년도</span>
            </div>
            <div class="form-category">
                <div class="input-group">
                    <input type="text" class="short" id="completionYear" placeholder="1991" name="completionYear">
                    <p class="icon"><i class="fas">년</i></p>
                </div>
            </div>
        </div>
    </div>
</section>
