<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="salePrice" value="${fn:length(offer.salePrice) > 4 ? offer.salePrice / 10000 : offer.salePrice}" />
<c:set var="loan" value="${fn:length(offer.loan) > 4 ? offer.loan / 10000 : offer.loan}" />

<div class="row bb">
    <c:choose>
        <c:when test="${offer.dealType eq 'SALE'}">
            <p class="key">매매가</p>
            <p class="value">${salePrice}${fn:length(offer.salePrice) > 4 ? "억" : "만"}</p>
            <p class="key">융자금</p>
            <p class="value">${fn:replace(loan, ".0", "")}</p>
        </c:when>
        <c:otherwise>
            <p class="key">보증금</p>
            <p class="value">${offer.deposit}</p>
            <p class="key">월세</p>
            <p class="value">${offer.monthlyPrice}</p>
        </c:otherwise>
    </c:choose>
</div>

<div class="row bb">
<%--    <p class="key">난방방식</p>--%>
<%--    <p class="value">${offer.heatingMethodType.value}</p>--%>
    <p class="key">입주가능일</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${offer.offerAddition.moveIn ne "" ? offer.offerAddition.moveIn : "정보없음"}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
    <p class="key">총세대수</p>
    <p class="value">
        ${offer.offerAddition.households ne "" ? offer.offerAddition.households.concat(" 세대") : "정보없음"}
    </p>
</div>

<div class="row bb">
    <p class="key">총동수</p>
    <p class="value">
        ${offer.offerAddition.totalDong ne "" ? offer.offerAddition.totalDong.concat("동") : "정보없음"}
    </p>
    <p class="key">총주차수</p>
    <p class="value">
        ${offer.offerAddition.totalParking ne "" ? offer.offerAddition.totalParking.concat(" 대") : "정보없음"}
    </p>
</div>

<div class="row bb">
    <p class="key">전체층</p>
    <p class="value">
        ${offer.offerAddress.floor ne "" ? "총 ".concat(offer.offerAddress.floor).concat("층") : "정보없음"}
    </p>
    <p class="key">해당동</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${offer.offerAddress.dong.concat("동")}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

<div class="row bb">
    <p class="key">현관구조</p>
    <p class="value">
        ${offer.offerAddition.frontStructure ne "" ? offer.offerAddition.frontStructure : "정보없음"}
    </p>
    <p class="key">방향</p>
    <p class="value">
        ${offer.offerAddition.direction ne "" ? offer.offerAddition.direction : "정보없음"}
    </p>
</div>

<div class="row bb">
    <p class="key">공급면적</p>
    <p class="value">
        ${offer.offerAddress.landArea ne "" ? offer.offerAddress.landArea.concat("㎡") : "정보없음"}
    </p>
    <p class="key">전용면적</p>
    <p class="value">
        ${offer.offerAddress.buildingArea ne "" ? offer.offerAddress.buildingArea.concat("㎡") : "정보없음"}
    </p>
</div>

<div class="row bb">
    <p class="key">방개수</p>
    <p class="value">${offer.offerAddition.rooms} 개</p>
    <p class="key">욕실개수</p>
    <p class="value">${offer.offerAddition.bathrooms} 개</p>
</div>

<div class="row bb">
    <p class="key">냉방시설</p>
    <p class="value">${offer.offerAddition.hasCool ? "유" : "무"}</p>
    <p class="key">계약상태</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${offer.offerAddition.tenant}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

<div class="row bb">
    <p class="key">리모델링</p>
    <p class="value">
        ${offer.offerAddition.remodeling ? "O" : "X"}
    </p>
    <c:if test="${offer.type eq 'APT'}">
        <p class="key">확장여부</p>
        <p class="value">${offer.offerAddition.builtIn ? "O" : "X"}</p>
    </c:if>
</div>

<div class="row bb">
    <p class="key">해당호실</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${offer.offerAddress.ho}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
    <c:if test="${offer.dealType ne 'SALE'}">
        <p class="key">룸비밀번호</p>
        <p class="value">
            <c:choose>
                <c:when test="${isPremium}">
                    ${offer.offerAddress.door}
                </c:when>
                <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
            </c:choose>
        </p>
    </c:if>
</div>
