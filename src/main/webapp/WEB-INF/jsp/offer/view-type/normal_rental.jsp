<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row bb">
    <p class="key">매물구분</p>
    <p class="value">
        ${offer.offerAddition.rooms eq null ? "정보없음" : offer.offerAddition.rooms}
    </p>
    <p class="key">입구</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${offer.offerAddress.entrance}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

<div class="row bb">
    <p class="key">보증금</p>
    <p class="value">${offer.deposit}</p>
    <p class="key">월세</p>
    <p class="value">${offer.monthlyPrice}</p>
</div>

<div class="row bb">
    <p class="key">관리비</p>
    <p class="value">${offer.managementPrice}</p>
    <p class="key">세입자</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${empty offer.offerAddition.tenant ? "정보없음" : offer.offerAddition.tenant}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

<div class="row bb">
    <p class="key">룸호실</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${empty offer.offerAddress.ho ? "정보없음" : offer.offerAddress.ho}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
    <p class="key">룸비밀번호</p>
    <p class="value">
        <c:choose>
            <c:when test="${isPremium}">
                ${offer.offerAddress.door}
            </c:when>
            <c:otherwise><i class="fas fa-lock"></i></c:otherwise>
        </c:choose>
    </p>
</div>

<div class="row bb">
    <p class="key">반려동물</p>
    <p class="value">${offer.offerAddition.canPet ? "가능" : "불가능"}</p>
    <p class="key">주차</p>
    <p class="value">${offer.offerAddition.canParking ? "가능" : "불가능"}</p>
</div>

<div class="row bb">
    <p class="key">단기임대</p>
    <p class="value">
        ${offer.offerAddition.term == null || offer.offerAddition.term == 0 ? "불가능" : offer.offerAddition.term}
        ${offer.offerAddition.term == null || offer.offerAddition.term == 0 ? "" : "개월"}
    </p>
</div>
