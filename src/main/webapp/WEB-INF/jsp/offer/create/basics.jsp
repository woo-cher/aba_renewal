<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="form-control mt-0">
    <div class="form-warp">
        <div class="deal-type">
            <div class="form-label relative">
                <i class="fas fa-circle"></i>
                <span class="required">거래유형</span>
                <div class="error-box"></div>
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
            </ul>
        </div>

        <div class="offer-type">
            <div class="form-label relative">
                <i class="fas fa-circle"></i>
                <span class="required">매물분류</span>
                <div class="error-box"></div>
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
            </ul>
        </div>

        <div class="heating-type">
            <div class="form-label relative">
                <i class="fas fa-circle"></i>
                <span class="required">난방유형</span>
                <div class="error-box"></div>
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
            </ul>
        </div>

        <div class="offer-deal">
            <div class="form-label relative">
                <i class="fas fa-circle"></i>
                <span class="required">매물가격 (보증금 / 월가격 + 관리비)</span>
                <div class="error-box"></div>
            </div>
            <div class="form-category p-1 full check-area">
                <div class="input-group">
                    <input type="text" class="middle price-group" id="deposit" placeholder="보증금" name="deposit" value="${offer.deposit}"
                           pattern="^[0-9]{1,5}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>
                    <p class="short"></p>
                    <input type="text" class="middle price-group" id="monthlyPrice" placeholder="월 가격" name="monthlyPrice" value="${offer.monthlyPrice}"
                           pattern="^[0-9]{1,3}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>

                    <div class="w-75 normal-rental" style="display: flex;">
                        &nbsp;<p class="short">+</p>&nbsp;
                        <input type="text" id="managementPrice" placeholder="관리비" name="managementPrice" value="${offer.managementPrice}"
                               pattern="^[0-9]{1,2}" onkeyup="formValidatorWithRegex($(this))">
                        <p class="icon"><i class="fas">만</i></p>
                    </div>
                </div>

                <div class="input-group normal-sale hidden">
                    <input type="text" class="middle" id="salePrice" placeholder="매매가 -> 예) 3.5" name="salePrice" value="${offer.salePrice}"
                           pattern="^[0-9.]{1,4}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">억</i></p>

                    <p class="short"></p>
                    <input type="text" class="middle" id="investmentMoney" placeholder="투자금액" name="investmentMoney" value="${offer.investmentMoney}"
                           pattern="^[0-9.]{1,3}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">억</i></p>
                </div>

                <div class="input-group normal-sale hidden">
                    <input type="text" class="middle" id="loan" placeholder="융자금 -> 예) 5000" name="loan" value="${offer.loan}"
                           pattern="^[0-9]{1,5}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>

                    <p class="short"></p>
                    <input type="text" class="middle" id="interest" placeholder="은행이자 -> 예) 4.25" name="interest" value="${offer.interest}"
                           pattern="^[0-9]{1,2}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">%</i></p>
                </div>

                <div class="input-group normal-sale hidden" id="profit">
                    <input type="text" class="middle" placeholder="월순수입 -> 예) 300" name="monthlyProfit" value="${offer.monthlyProfit}"
                           pattern="^[0-9]{1,2}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>
                </div>

                <div class="input-group office-type hidden">
                    <input type="text" class="middle" placeholder="권시비 -> 예) 300" name="suppliesPrice" value="${offer.suppliesPrice}"
                           pattern="^[0-9]{1,3}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">만</i></p>
                </div>
            </div>
        </div>

        <div class="year pt-3">
            <div class="form-label relative">
                <i class="fas fa-circle"></i>
                <span class="required">준공년도 / 문의 연락처</span>
                <div class="error-box"></div>
            </div>
            <div class="form-category p-1 check-area">
                <div class="input-group">
                    <input type="text" class="short" id="completionYear" placeholder="1991" name="completionYear" value="${offer.completionYear}"
                           pattern="^[0-9]{1,4}" onkeyup="formValidatorWithRegex($(this))">
                    <p class="icon"><i class="fas">년</i></p>
                    <p class="short">/</p>
                    <input type="text" class="middle" id="inquiryTel" placeholder="010-0000-0000" name="inquiryTel" value="${offer.inquiryTel}"
                           pattern="^[0-9-]{1,13}" onkeyup="formValidatorWithRegex($(this))">
                </div>
            </div>
        </div>
    </div>
</section>
