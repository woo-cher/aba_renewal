<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section class="form-control mt-0" hidden>
    <div class="normal-rental room-type">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span class="required">옵션 정보</span>
            <div class="error-box"></div>
        </div>
        <ul class="checkbox-container p-1 check-area">
            <c:forEach var="option" items="${options}" begin="1" varStatus="vs">
                <li class="checkbox-list" style="width: 15%;">
                    <c:choose>
                        <c:when test="${fn:contains(offer.offerAddition.optionCategory, vs.index)}">
                            <input id="option${vs.index}" type="checkbox" name="offerAddition.optionCategory" value="${vs.index}" class="check" checked>
                        </c:when>
                        <c:otherwise>
                            <input id="option${vs.index}" type="checkbox" name="offerAddition.optionCategory" value="${vs.index}" class="check">
                        </c:otherwise>
                    </c:choose>
                    <label for="option${vs.index}">
                            ${option.value}
                    </label>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="apt hidden">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>현관구조 / 방향</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="short" placeholder="(계단식 / 복합식)" name="offerAddition.frontStructure" value="${offer.offerAddition.frontStructure}">
            <p class="short">/</p>
            <input type="text" class="short" placeholder="(남향 / 동향 / 서향 ...)" name="offerAddition.direction" value="${offer.offerAddition.direction}">
        </div>

        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>입주가능일</span>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="large" placeholder="입주가능일" name="offerAddition.moveIn" value="${offer.offerAddition.moveIn}"
                   pattern="^[0-9- 가-힣]{1,20}" onkeyup="formValidatorWithRegex($(this))">
        </div>

        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>방 / 욕실 개수</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="short" placeholder="방 갯수" name="offerAddition.rooms" value="${offer.offerAddition.rooms}"
                   pattern="^[0-9.]{1}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">개</i></p>
            <p class="short">/</p>
            <input type="text" class="short" placeholder="욕실 갯수" name="offerAddition.bathrooms" value="${offer.offerAddition.bathrooms}"
                   pattern="^[0-9.]{1}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">개</i></p>
        </div>
    </div>

    <div class="form-label relative">
        <i class="fas fa-circle"></i>
        <span>부가 정보</span>
    </div>
    <ul class="checkbox-container p-1">
        <li class="checkbox-list normal-rental" style="width: 15%;">
            <input id="tenant" type="checkbox" class="check" onchange="dynamicFormTrigger($(this))">
            <label for="tenant">세입자 있음</label>
        </li>
        <li class="checkbox-list room-type normal-rental" style="width: 15%;" id="term-box">
            <input id="term" type="checkbox" class="check" onchange="dynamicFormTrigger($(this))">
            <label for="term">단기 가능</label>
        </li>
        <li class="checkbox-list normal-sale" style="width: 15%;">
            <input id="elevator" type="checkbox" name="offerAddition.hasElevator" value=true class="check"
                   onchange="elevatorTrigger($(this))"
            >
            <label for="elevator">승강기 있음</label>
        </li>
        <li class="checkbox-list hidden" style="width: 15%;" id="remodeling">
            <input id="remodel" type="checkbox" name="offerAddition.remodeling" value=true class="check"
                   onchange="elevatorTrigger($(this))"
            >
            <label for="remodel">리모델링</label>
        </li>
        <li class="checkbox-list apt hidden" style="width: 15%;">
            <input id="builtIn" type="checkbox" name="offerAddition.builtIn" class="check">
            <label for="builtIn">확장공사</label>
        </li>
        <li class="checkbox-list normal-rental" style="width: 15%;">
            <input id="parking" type="checkbox" name="offerAddition.canParking" class="check">
            <label for="parking">주차 가능</label>
        </li>
        <li class="checkbox-list normal-rental" style="width: 15%;">
            <input id="pet" type="checkbox" name="offerAddition.canPet" class="check">
            <label for="pet">반려 가능</label>
        </li>
        <li class="checkbox-list apt hidden" style="width: max-content;">
            <input id="cool" type="checkbox" name="offerAddition.hasCool" class="check">
            <label for="cool">냉방시설 있음</label>
        </li>
    </ul>

    <div id="tenantDesc" hidden>
        <div class="input-group">
            <label class="form-label relative">* 세입자 : </label>
            <input type="text" class="short" name="offerAddition.tenant" placeholder="예) 유(3월말)" value="무">
        </div>
    </div>

    <div id="howTerm" hidden>
        <div class="input-group">
            <label class="form-label relative">* 단기 가능일 : <span class="aba">최대</span></label>
            <input type="text" class="short" name="offerAddition.term" placeholder="예) 3" value="0">
            <p class="icon"><i class="fas">개월</i></p>
        </div>
    </div>

    <div class="normal-rental room-type">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span class="required">관리비 항목</span>
            <div class="error-box"></div>
        </div>
        <ul class="checkbox-container p-1 check-area">
            <c:forEach var="manage" items="${manages}" begin="1" varStatus="vs">
                <li class="checkbox-list" style="width: 15%;">
                    <c:choose>
                        <c:when test="${fn:contains(offer.offerAddition.managementCategory, vs.index)}">
                            <input id="manage${vs.index}" type="checkbox" name="offerAddition.managementCategory" value="${vs.index}" class="check" checked>
                        </c:when>
                        <c:otherwise>
                            <input id="manage${vs.index}" type="checkbox" name="offerAddition.managementCategory" value="${vs.index}" class="check">
                        </c:otherwise>
                    </c:choose>
                    <label for="manage${vs.index}">
                            ${manage.value}
                    </label>
                </li>
                <c:if test="${manage.value eq '엘리베이터'}">
                    <script>$('#manage5').parent().hide()</script>
                </c:if>
            </c:forEach>
        </ul>
    </div>

    <div class="office-type hidden">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>업종 정보</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group flex-center check-area">
            <p class="icon w-max p-1"><i class="fas">현재업종</i></p>
            <input type="text" class="short" name="offerAddition.industry" placeholder="예) 네일샵"
                   value="${offer.offerAddition.industry}">
            <p class="short"></p>
            <p class="icon w-max p-1"><i class="fas">제한업종</i></p>
            <input type="text" class="short" name="offerAddition.restrictedIndustry" placeholder="예) 유흥업"
                   value="${offer.offerAddition.restrictedIndustry}">
        </div>
    </div>

    <div class="form-label relative">
        <i class="fas fa-circle"></i>
        <span>부가 설명</span>
    </div>
    <input type="text" name="description" placeholder="예) 벽지 재공사 예정이라고 합니다~" value="${offer.description}"
           pattern="^[0-9가-힣-#*~:!() ]{1,50}" onkeyup="formValidatorWithRegex($(this))">

    <div class="form-label relative">
        <i class="fas fa-circle"></i>
        <span class="w-25">사진 등록</span>
        <div id="thumbTrigger" class="txt-sm fr aba align-right c-pointer w-half in-flex flex-end item-center" onclick="setThumbnailTrigger()">
            <i class="fas fa-exchange-alt thumb-message"></i>
            <p class="pl-3 thumb-message">대표사진 변경</p>
            <p class="pl-3 thumb-message aba invalid" hidden>취소하기</p>
        </div>
    </div>
    <div id="abaDropzone" class="dropzone align-center pt-3">
        <div class="dz-default dz-message">
            <img src="/web-resources/img/offer/add_image.png">
            <p class="aba pt-3">사진을 끌어다 놓거나 눌러서 업로드 해주세요 :)</p>
        </div>
    </div>
</section>
