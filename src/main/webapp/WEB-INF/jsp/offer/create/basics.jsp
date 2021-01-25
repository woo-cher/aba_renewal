<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="form-control mt-0">
    <div class="form-warp">
        <div class="deal-type">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>거래유형</span>
            </div>
            <ul class="checkbox-container form type pt-1 check-area">
                <c:forEach begin="1" var="type" items="${dealTypes}" varStatus="vs">
                    <li class="checkbox-list">
                        <c:choose>
                            <c:when test="${type.value eq offer.dealType.value}">
                                <input id="dealType${vs.index}" type="radio" name="dealType" value="${type.code}" class="check" checked>
                            </c:when>
                            <c:otherwise>
                                <input id="dealType${vs.index}" type="radio" name="dealType" value="${type.code}" class="check">
                            </c:otherwise>
                        </c:choose>
                        <label for="dealType${vs.index}">${type.value}</label>
                    </li>
                </c:forEach>
                <div class="error-box"></div>
            </ul>
        </div>

        <div class="offer-type">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>매물분류</span>
            </div>
            <ul class="checkbox-container form type pt-1 check-area">
                <c:forEach begin="1" var="type" items="${offerTypes}" varStatus="vs">
                    <li class="checkbox-list half">
                        <c:choose>
                            <c:when test="${type.value eq offer.type.value}">
                                <input id="offerType${vs.index}" type="radio" name="type" value="${type.code}" class="check" checked>
                            </c:when>
                            <c:otherwise>
                                <input id="offerType${vs.index}" type="radio" name="type" value="${type.code}" class="check">
                            </c:otherwise>
                        </c:choose>
                        <label for="offerType${vs.index}">${type.value}</label>
                    </li>
                </c:forEach>
                <div class="error-box"></div>
            </ul>
        </div>

        <div class="heating-type">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>난방유형</span>
            </div>
            <ul class="checkbox-container form type pt-1 check-area">
                <c:forEach begin="1" var="type" items="${heatingTypes}" varStatus="vs">
                    <li class="checkbox-list half">
                        <c:choose>
                            <c:when test="${type.value eq offer.heatingType.value}">
                                <input id="heatingType${vs.index}" type="radio" name="heatingType" value="${type.code}" class="check" checked>
                            </c:when>
                            <c:otherwise>
                                <input id="heatingType${vs.index}" type="radio" name="heatingType" value="${type.code}" class="check">
                            </c:otherwise>
                        </c:choose>
                        <label for="heatingType${vs.index}">${type.value}</label>
                    </li>
                </c:forEach>
                <div class="error-box"></div>
            </ul>
        </div>

        <div class="offer-deal">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>매물가격 (보증금 / 달세 + 관리비)</span>
            </div>
            <div class="form-category flex p-1 full check-area">
                <div class="input-group">
                    <input type="text" class="short" id="deposit" placeholder="보증금" name="deposit" value="${offer.deposit}"
                           pattern="^[0-9]{1,5}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>
                    <p class="short">/</p>
                    <input type="text" class="short" id="monthlyPrice" placeholder="달세" name="monthlyPrice" value="${offer.monthlyPrice}"
                           pattern="^[0-9]{1,3}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>
                    <p class="short">+</p>
                    <input type="text" class="short" id="managementPrice" placeholder="관리비" name="managementPrice" value="${offer.managementPrice}"
                           pattern="^[0-9]{1,2}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>
                    <div class="error-box"></div>
                </div>
            </div>
        </div>

        <div class="year pt-3">
            <div class="form-label">
                <i class="fas fa-circle"></i>
                <span>준공년도 / 문의 연락처</span>
            </div>
            <div class="form-category p-1 check-area">
                <div class="input-group">
                    <input type="text" class="short" id="completionYear" placeholder="1991" name="completionYear" value="${offer.completionYear}"
                           pattern="^[0-9]{1,4}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">년</i></p>
                    <p class="short">/</p>
                    <div class="error-box"></div>
                    <input type="text" class="middle" id="inquiryTel" placeholder="010-0000-0000" name="inquiryTel" value="${offer.inquiryTel}"
                           pattern="^[0-9-]{1,13}" onkeyup="formValidatorWithRegex($(this))">
                </div>
            </div>
        </div>
    </div>
</section>
