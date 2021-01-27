<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row bb">
    <p class="key">매물구분</p>
    <p class="value">${offer.offerAddition.rooms}</p>
    <p class="key">층정보</p>
    <p class="value">${offer.offerAddress.floor}</p>
</div>

<div class="row bb">
    <p class="key">보증금</p>
    <p class="value">${offer.deposit}</p>
    <p class="key">월세</p>
    <p class="value">${offer.monthlyPrice}</p>
</div>

<div class="row bb">
    <p class="key">면적</p>
    <p class="value">${offer.offerAddress.buildingArea}㎡</p>
    <p class="key">현재업종</p>
    <p class="value">${offer.offerAddition.industry}</p>
</div>

<div class="row bb">
    <p class="key">제한업종</p>
    <p class="value">${empty offer.offerAddition.restrictedIndustry ? "정보없음" : offer.offerAddition.restrictedIndustry}</p>
    <p class="key">상가호실</p>
    <p class="value">${offer.offerAddress.floor}</p>
</div>

<div class="row bb">
    <p class="key">관리비</p>
    <p class="value">${offer.managementPrice}</p>
    <p class="key">권시비</p>
    <p class="value">${offer.suppliesPrice}</p>
</div>

<div class="row bb">
    <p class="key">비밀번호</p>
    <p class="value">${offer.offerAddress.door}</p>
</div>
