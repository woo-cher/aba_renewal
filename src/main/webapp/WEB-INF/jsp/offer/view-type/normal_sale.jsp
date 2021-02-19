<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="households" value="${fn:split(offer.offerAddition.householdInfo, ',')}" />
<c:set var="salePrice" value="${offer.salePrice / 10000}" />
<c:set var="loan" value="${fn:length(offer.loan) > 4 ? offer.loan / 10000 : offer.loan}" />
<c:set var="totalDeposit" value="${fn:length(offer.deposit) > 4 ? offer.deposit / 10000 : offer.deposit}" />
<c:set var="investment" value="${fn:length(offer.investmentMoney) > 4 ? offer.investmentMoney / 10000 : offer.investmentMoney}" />

<div class="row bb">
    <p class="key">엘리베이터</p>
    <p class="value">${offer.offerAddition.hasElevator ? "있음" : "없음"}</p>
    <p class="key">전체층</p>
    <p class="value">${offer.offerAddress.floor}</p>
</div>

<div class="row bb">
    <p class="key">건물연면적</p>
    <p class="value">${offer.offerAddress.buildingArea}㎡</p>
    <p class="key">대지면적</p>
    <p class="value">${offer.offerAddress.landArea}㎡</p>
</div>

<div class="row bb">
    <p class="key">지하세대</p>
    <p class="value">${empty households[0] ? "정보없음" : households[0]}</p>
    <p class="key">1층세대</p>
    <p class="value">${empty households[1] ? "정보없음" : households[1]}</p>
</div>

<div class="row bb">
    <p class="key">2층세대</p>
    <p class="value">${empty households[2] ? "정보없음" : households[2]}</p>
    <p class="key">3층세대</p>
    <p class="value">${empty households[3] ? "정보없음" : households[3]}</p>
</div>

<div class="row bb">
    <p class="key">4층세대</p>
    <p class="value">${empty households[4] ? "정보없음" : households[4]}</p>
    <p class="key">5층세대</p>
    <p class="value">${empty households[5] ? "정보없음" : households[5]}</p>
</div>

<div class="row bb">
    <p class="key">6층세대</p>
    <p class="value">${empty households[6] ? "정보없음" : households[6]}</p>
    <p class="key">매매가</p>
    <p class="value">${fn:replace(salePrice, ".0", "")}${fn:length(offer.salePrice) > 4 ? "억" : "만"}</p>
</div>

<div class="row bb">
    <p class="key">총 보증금</p>
    <p class="value">${totalDeposit}${fn:length(offer.deposit) > 4 ? "억" : ""}</p>
    <p class="key">융자금</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${fn:replace(loan, ".0", "")}${fn:length(offer.loan) > 4 ? "억" : ""}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

<div class="row bb">
    <p class="key">은행이자</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">${offer.interest}%</c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
    <p class="key">월 임대총액</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">${offer.monthlyPrice}</c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

<div class="row bb">
    <p class="key">투자금액</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${fn:replace(investment, ".0", "")}${fn:length(offer.investmentMoney) > 4 ? "억" : ""}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
    <p class="key">월 순수입</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">${offer.monthlyProfit}</c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

