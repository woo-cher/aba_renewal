<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="form-control mt-0" hidden>
    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>옵션 정보</span>
    </div>
    <ul class="checkbox-container p-1">
        <c:forEach var="option" items="${options}" begin="1" varStatus="vs">
            <li class="checkbox-list" style="width: 15%;">
                <input id="option${vs.index}" type="checkbox" name="optionCategory" value="${vs.index}" class="check">
                <label for="option${vs.index}">
                        ${option.value}
                </label>
            </li>
        </c:forEach>
    </ul>

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>부가 정보</span>
    </div>
    <ul class="checkbox-container p-1">
        <li class="checkbox-list" style="width: 15%;">
            <input id="tenant" type="checkbox" class="check" onchange="dynamicFormTrigger($(this))">
            <label for="tenant">세입자 있음</label>
        </li>
        <li class="checkbox-list" style="width: 15%;">
            <input id="term" type="checkbox" class="check" onchange="dynamicFormTrigger($(this))">
            <label for="term">단기 가능</label>
        </li>
        <li class="checkbox-list" style="width: 15%;">
            <input id="elvator" type="checkbox" name="hasElevator" value=true class="check"
                   onchange="elevatorTrigger($(this))"
            >
            <label for="elvator">승강기 있음</label>
        </li>
        <li class="checkbox-list" style="width: 15%;">
            <input id="parking" type="checkbox" name="isParking" value=true class="check">
            <label for="parking">주차 가능</label>
        </li>
        <li class="checkbox-list" style="width: 15%;">
            <input id="pet" type="checkbox" name="isPet" value=true class="check">
            <label for="pet">반려 가능</label>
        </li>
    </ul>

    <div id="tenantDesc" hidden>
        <div class="input-group">
            <label class="form-label">* 세입자 : </label>
            <input type="text" class="short" name="tenant" placeholder="예) 유(3월말)">
        </div>
    </div>

    <div id="howTerm" hidden>
        <div class="input-group">
            <label class="form-label">* 단기 가능일 : <span class="aba">최대</span></label>
            <input type="text" class="short" name="term" placeholder="예) 3">
            <p class="icon"><i class="fas">개월</i></p>
        </div>
    </div>

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>관리비 항목</span>
    </div>
    <ul class="checkbox-container p-1">
        <c:forEach var="manage" items="${manages}" begin="1" varStatus="vs">
            <li class="checkbox-list" style="width: 15%;">
                <input id="manage${vs.index}" type="checkbox" name="managementCategory" value="${vs.index}" class="check">
                <label for="manage${vs.index}">
                        ${manage.value}
                </label>
            </li>
            <c:if test="${manage.value eq '엘리베이터'}">
                <script>$('#manage5').parent().hide()</script>
            </c:if>
        </c:forEach>
    </ul>

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>부가 설명</span>
    </div>
    <input type="text" name="description" placeholder="예) 벽지 재공사 예정이라고 합니다~">

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>사진 등록</span>
    </div>
    <div class="image-area pt-3">
        <div id="dropzone" class="dropzone align-center">
            <div class="dz-default dz-message">
                <img src="/img/offer/add_image.png">
                <p class="aba pt-3">사진을 끌어다 놓거나 눌러서 업로드 해주세요 :)</p>
            </div>
            <input type="hidden" name="offerIdForDirectory" value="1234"/>
            <input hidden type="file" id="files" name="files" multiple />
        </div>
    </div>
</section>
