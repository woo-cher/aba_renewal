<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="filter-bar">
    <ul class="filter-group">
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-home fa-sm"></i>
                매물분류
            </a>
            <div class="filter-detail">
                <div class="detail-container offer-type">
                    <header class="detail-header">
                        <p class="title">매물분류</p>
                        <p class="caption">중복선택이 가능해요 ;)</p>
                    </header>

                    <ul class="checkbox-container">
                        <c:if test="${not empty offerTypes}">
                            <c:forEach var="offerType" items="${offerTypes}" begin="1" varStatus="vs">
                            <li class="checkbox-list">
                                <input id="offerType${vs.index}" type="checkbox" name="offerType" value="${offerType}" class="check">
                                <label for="offerType${vs.index}" onclick="updateDtoModel($(this).prev())">
                                    ${offerType.value}
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
                거래유형
            </a>
            <div class="filter-detail">
                <div class="detail-container deal">
                    <header class="detail-header">
                        <p class="title">거래유형</p>
                        <p class="caption">중복선택이 가능해요 ;)</p>
                    </header>

                    <ul class="checkbox-container">
                        <c:if test="${not empty dealTypes}">
                            <c:forEach var="dealType" items="${dealTypes}" begin="1" varStatus="vs">
                                <li class="checkbox-list" style="width: 28%;">
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
                <i class="fas fa-hand-holding-usd fa-sm"></i>
                보증금
            </a>
            <div class="filter-detail">
                <div class="detail-container deal">
                    <header class="detail-header">
                        <p class="title">
                            보증금
                            <span class="caption slide" id="deposit-val">무제한</span>
                        </p>
                    </header>

                    <div class="custom-slider">
                        <input type="range" min="0" max="50000" value="50000" step="5000" list="deposit-vals" name="deposit"
                               class="slider" id="deposit" onchange="set_slide_value($(this), $('#deposit-val'))"
                        />
                        <datalist id="deposit-vals">
                            <option value="0">(억)</option>
                            <option value="10000">1</option>
                            <option value="20000">2</option>
                            <option value="30000">3</option>
                            <option value="40000">4</option>
                            <option value="-1">∞</option>
                        </datalist>
                    </div>
                </div>
            </div>
        </li>
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-money-bill-alt fa-sm"></i>
                월세
            </a>
            <div class="filter-detail">
                <div class="detail-container deal">
                    <header class="detail-header">
                        <p class="title">
                            월세
                            <span class="caption slide" id="monthly-val">무제한</span>
                        </p>
                    </header>

                    <div class="custom-slider">
                        <input type="range" min="0" max="105" value="105" step="5" list="monthly-vals" name="monthlyPrice"
                               class="slider" id="monthly" onchange="set_slide_value($(this), $('#monthly-val'))"
                        />
                        <datalist id="monthly-vals">
                            <option value="0">0</option>
                            <option value="50" style="">50만</option>
                            <option value="-1" style="">∞</option>
                        </datalist>
                    </div>
                </div>
            </div>
        </li>
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-sort-amount-down-alt fa-sm"></i>
                상세필터
            </a>
            <div class="filter-detail">
                <div class="detail-container all">
                    <div class="detail-wrap">
                        <header class="detail-header">
                            <p class="title">추가 항목</p>
                            <p class="caption">복수 선택</p>
                        </header>

                        <ul class="checkbox-container">
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="parking" type="checkbox" name="isParking" value=true class="check">
                                <label for="parking" onclick="updateDtoModel($(this).prev())">주차 가능</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="tenaunt" type="checkbox" name="isNotTenant" value=true class="check">
                                <label for="tenaunt" onclick="updateDtoModel($(this).prev())">세입자 없음</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="elvator" type="checkbox" name="hasElevator" value=true class="check">
                                <label for="elvator" onclick="updateDtoModel($(this).prev())">승강기 있음</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="term" type="checkbox" name="isCanTerm" value=true class="check">
                                <label for="term" onclick="updateDtoModel($(this).prev())">단기 가능</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="pet" type="checkbox" name="isPet" value=true class="check">
                                <label for="pet" onclick="updateDtoModel($(this).prev())">반려 가능</label>
                            </li>
                        </ul>
                    </div>
                    <div class="detail-wrap">
                        <header class="detail-header">
                            <p class="title">층수</p>
                            <p class="caption">단일 선택</p>
                        </header>

                        <ul class="checkbox-container">
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="floor" type="radio" name="floor" value="0" class="check" checked>
                                <label for="floor" onclick="updateDtoModel($(this).prev())">전체</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="floor0" type="radio" name="floor" value="-1" class="check">
                                <label for="floor0" onclick="updateDtoModel($(this).prev())">반지하</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%;">
                                <input id="floorT" type="radio" name="floor" value="100" class="check">
                                <label for="floorT" onclick="updateDtoModel($(this).prev())">옥탑</label>
                            </li>
                            <c:forEach begin="1" end="6" varStatus="vs">
                                <li class="checkbox-list" style="width: 28%;">
                                    <input id="floor${vs.index}" type="radio" name="floor" value="${vs.index}" class="check">
                                    <label for="floor${vs.index}" onclick="updateDtoModel($(this).prev())">
                                        <c:choose>
                                            <c:when test="${vs.index eq 6}">${vs.index}층 이상</c:when>
                                            <c:otherwise>${vs.index}층</c:otherwise>
                                        </c:choose>
                                    </label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="detail-wrap">
                    <header class="detail-header">
                        <p class="title">준공년도</p>
                        <p class="caption">단일 선택</p>
                    </header>

                    <ul class="checkbox-container">
                        <li class="checkbox-list" style="width: 28%;">
                            <input id="year0" type="radio" name="year" value="0" class="check" checked>
                            <label for="year0" onclick="updateDtoModel($(this).prev())">전체</label>
                        </li>
                        <li class="checkbox-list" style="width: 28%;">
                            <input id="year1" type="radio" name="year" value="1" class="check">
                            <label for="year1" onclick="updateDtoModel($(this).prev())">1년 이내</label>
                        </li>
                        <li class="checkbox-list" style="width: 28%;">
                            <input id="year2" type="radio" name="year" value="5" class="check">
                            <label for="year2" onclick="updateDtoModel($(this).prev())">5년 이내</label>
                        </li>
                        <li class="checkbox-list" style="width: 28%;">
                            <input id="year3" type="radio" name="year" value="10" class="check">
                            <label for="year3" onclick="updateDtoModel($(this).prev())">10년 이내</label>
                        </li>
                        <li class="checkbox-list" style="width: 28%;">
                            <input id="year4" type="radio" name="year" value="15" class="check">
                            <label for="year4" onclick="updateDtoModel($(this).prev())">15년 이내</label>
                        </li>
                        <li class="checkbox-list" style="width: 28%;">
                            <input id="year5" type="radio" name="year" value="100" class="check">
                            <label for="year5" onclick="updateDtoModel($(this).prev())">15년 이상</label>
                        </li>
                    </ul>
                </div>

                <div class="detail-wrap w-full">
                    <header class="detail-header h-half">
                        <p class="title inline">옵션<span class="caption">복수 선택</span></p>
                    </header>
                    <ul class="checkbox-container p-1">
                        <c:if test="${not empty options}">
                            <c:forEach var="option" items="${options}" begin="1" varStatus="vs">
                                <li class="checkbox-list" style="width: 15%;">
                                    <input id="option${vs.index}" type="checkbox" name="option" value="${vs.index}" class="check">
                                    <label for="option${vs.index}" onclick="updateDtoModel($(this).prev())">
                                            ${option.value}
                                    </label>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>

            </div>
        </li>
    </ul>
</div>

<script>
    const filtersDto = {
        offerType: [],
        dealType: [],
        deposit: '0',
        monthlyPrice: '0',
        isParking: false,
        isNotTenant: false,
        hasElevator: false,
        isCanTerm: false,
        isPet: false,
        floor: '0',
        year: '0',
        option: []
    };

    function updateDtoModel(focus) {
        const key = focus.attr('name');
        let element = filtersDto[key];

        if(typeof element === 'object') {
            focus.is(":checked") ? // 이게 이상하게 반대로 작동함
            removeSpecifiedElement(filtersDto[key], filtersDto[key].indexOf(focus.val())) :
            filtersDto[key].push(focus.val())
        } else if(typeof element === 'boolean') {
            filtersDto[key] = !focus.is(":checked");
        } else {
            filtersDto[key] = focus.val();
        }

        mapManager.eventTrigger();
    }

    function removeSpecifiedElement(array, indexOf) {
        array.splice(indexOf, 1);
    }

    $(document).ready(function () {
        let coll = document.getElementsByClassName("collapsible");
        let last;

        for (let i = 0; i < coll.length; i++) {
            coll[i].addEventListener("click", function() {
                if(last !== undefined && last !== this) {
                    last.classList.toggle("active");
                    last.nextElementSibling.style.maxHeight = null;
                    last.nextElementSibling.style.border = null;
                }

                this.classList.toggle("active");

                const content = this.nextElementSibling;

                if (content.style.maxHeight){
                    content.style.maxHeight = null;
                    content.style.border = null;
                    last = undefined
                } else {
                    content.style.maxHeight = "100%";
                    content.style.border = "1px solid rgb(187, 187, 187)";
                    last = this;
                }
            });
        }
    });

    function set_slide_value(focus, value_area) {
        let value = focus.val();
        console.log(value);

        if (value === '0' || value === '50000' || value === '105') {
            value = "무제한";
        } else if (value.toString().length <= 4) {
            value = "~" + value + "만원"
        } else {
            value = "~" + (value / 10000) + "억";
        }

        value_area.text(value);

        updateDtoModel(focus);
    }
</script>
