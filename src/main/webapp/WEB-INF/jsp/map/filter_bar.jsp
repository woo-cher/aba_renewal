<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="url" value="${pageContext.request.requestURL}" />

<div class="filter-bar admin-filter">
    <ul class="filter-group">
        <li class="filter-el">
            <form id="offer-type">
                <a class="collapsible" href="#">
                    <i class="fas fa-home fa-sm"></i>
                    매물분류
                </a>
                <div class="filter-detail">
                    <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                        <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
                    </div>

                    <div class="detail-container offer-type">
                        <header class="detail-header">
                            <p class="title">매물분류</p>
                            <p class="caption">중복선택이 가능해요 ;)</p>
                        </header>

                        <ul class="checkbox-container" id="offerType">
                            <c:if test="${not empty offerTypes}">
                                <c:forEach var="offerType" items="${offerTypes}" begin="1" varStatus="vs">
                                <li class="checkbox-list">
                                    <input id="offerType${vs.index}" type="checkbox" name="offerTypes" value="${offerType}" class="check">
                                    <label for="offerType${vs.index}" onclick="updateDtoModel($(this).prev())">
                                        ${offerType.value}
                                    </label>
                                </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </form>
        </li>
        <li class="filter-el">
            <form id="deal-type">
                <a class="collapsible" href="#">
                    <i class="fas fa-handshake fa-sm"></i>
                    거래유형
                </a>
                <div class="filter-detail">
                    <div class="detail-container deal">
                        <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                            <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
                        </div>

                        <header class="detail-header">
                            <p class="title">거래유형</p>
                            <p class="caption">중복선택이 가능해요 ;)</p>
                        </header>

                        <ul class="checkbox-container">
                            <c:if test="${not empty dealTypes}">
                                <c:forEach var="dealType" items="${dealTypes}" begin="1" varStatus="vs">
                                    <li class="checkbox-list" style="width: 28%;">
                                        <input id="dealType${vs.index}" type="checkbox" name="dealTypes" value="${dealType}" class="check">
                                        <label for="dealType${vs.index}" onclick="updateDtoModel($(this).prev())">
                                                ${dealType.value}
                                        </label>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </form>
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
                        <input type="range" min="0" value="47" step="1" list="deposit-vals" name="deposit"
                               class="slider" id="deposit" oninput="set_array_slide_value($(this), $('#deposit-val'), depositValues)"
                               onchange="updateDtoModel($(this))"
                        />
                        <datalist id="deposit-vals">
                            <option value="0">0</option>
                            <option value="15000">1억 3,000만</option>
                            <option value="-1">∞</option>
                        </datalist>
                    </div>
                </div>

                <div class="detail-container deal sale-filter">
                    <header class="detail-header">
                        <p class="title">
                            매매가
                            <span class="caption slide" id="sale-val">무제한</span>
                        </p>
                    </header>

                    <div class="custom-slider">
                        <input type="range" min="0" value="24" step="1" list="sale-vals" name="salePrice"
                               class="slider" id="salePrice" oninput="set_array_slide_value($(this), $('#sale-val'), salePriceValues)"
                               onchange="updateDtoModel($(this))"
                        />
                        <datalist id="sale-vals">
                            <option value="0">0</option>
                            <option value="0">무제한</option>
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
                               class="slider" id="monthly" oninput="set_slide_value($(this), $('#monthly-val'))"
                               onchange="updateDtoModel($(this));"
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
            <form  id="offer-detail">
                <a class="collapsible" href="#">
                    <i class="fas fa-sort-amount-down-alt fa-sm"></i>
                    상세필터
                </a>
                <div class="filter-detail">
                    <div class="detail-container all">
                        <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                            <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))">&nbsp;초기화</i>
                        </div>

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
                </div>
            </form>
        </li>
        <c:if test="${fn:contains(url, 'admin')}">
        <li class="filter-el">
            <form id="offer-status">
                <a class="collapsible" href="#">
                    <i class="fas fa-eye fa-sm"></i>
                    매물상태
                </a>
                <div class="filter-detail">
                    <div class="f-c" style="position: absolute; right: 25px; top: 20px;">
                        <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
                    </div>

                    <div class="detail-container deal">
                        <header class="detail-header">
                            <p class="title">매물상태</p>
                            <p class="caption">중복선택이 가능해요 ;)</p>
                        </header>

                        <ul class="checkbox-container flex-center" id="status">
                            <li class="checkbox-list" style="width: 28%">
                                <input id="status1" type="checkbox" name="offerStatus" value="ON" class="check">
                                <label for="status1" onclick="updateDtoModel($(this).prev())">진행중</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%">
                                <input id="status2" type="checkbox" name="offerStatus" value="OFF" class="check">
                                <label for="status2" onclick="updateDtoModel($(this).prev())">미진행</label>
                            </li>
                            <li class="checkbox-list" style="width: 28%">
                                <input id="status3" type="checkbox" name="offerStatus" value="HIDE" class="check">
                                <label for="status3" onclick="updateDtoModel($(this).prev())">숨김</label>
                            </li>
                        </ul>
                    </div>
                </div>
            </form>
        </li>
        </c:if>
    </ul>
</div>

<script>
    let depositValues = ['0', '100', '200', '300', '400', '500', '1000', '1500', '2000', '2500', '3000', '3500', '4000',
        '4500', '5000', '5500', '6000', '6500', '7000', '8000', '9000', '10000', '11000', '12000', '13000', '14000', '15000',
        '16000', '17000', '18000', '19000', '20000', '25000', '30000', '35000', '40000', '45000', '50000', '55000', '60000',
        '65000', '70000', '75000', '80000', '85000', '90000', '95000', '0'];

    let salePriceValues = ['0', '3000', '5000', '10000', '15000', '20000', '25000', '30000', '35000', '40000', '45000', '50000',
        '55000', '60000', '70000', '80000', '90000', '100000', '110000', '120000', '130000', '140000', '150000', '0'];

    function hideCss(el) {
        el.css('cursor', 'no-drop');
        el.css('opacity', '.5');
    }

    function showCss(el) {
        el.css('cursor', 'none');
        el.css('opacity', '1');
    }

    $(document).ready(function () {
        let coll = document.getElementsByClassName("collapsible");
        let last;

        $('#deposit').prop('max', depositValues.length - 1);
        $('#salePrice').prop('max', salePriceValues.length - 1);

        $('input[name="dealTypes"]').click(function (e) {
            let saleBoxEl = $('.sale-filter');
            let saleSliderEl = $('#salePrice');
            let isSaleClicked = $('input[value="SALE"]').prop('checked');

            if (filtersDto['dealTypes'].length === 0 || isSaleClicked) {
                showCss(saleBoxEl);
                saleSliderEl.removeAttr('disabled');
            } else {
                hideCss(saleBoxEl);
                saleSliderEl.prop('disabled', true);
            }
        });

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

    let filtersDto = {
        offerTypes: [],
        dealTypes: [],
        offerStatus: [],
        deposit: '0',
        monthlyPrice: '0',
        salePrice: '0',
        isParking: false,
        isNotTenant: false,
        hasElevator: false,
        isCanTerm: false,
        isPet: false,
        floor: '0',
        year: '0',
        option: []
    };

    function resetDtoValues(focus) {
        $(focus).parents('form').map(function () {
            let id = this.id;

            switch (id) {
                case 'offer-type':
                    filtersDto['offerTypes'] = [];
                    break;
                case 'deal-type':
                    filtersDto['dealTypes'] = [];
                    break;
                case 'offer-status':
                    filtersDto['offerStatus'] = [];
                    break;
                case 'offer-detail':
                    filtersDto['deposit'] = '0';
                    filtersDto['monthlyPrice'] = '0';
                    filtersDto['salePrice'] = '0';
                    filtersDto['isParking'] = false;
                    filtersDto['isNotTenant'] = false;
                    filtersDto['hasElevator'] = false;
                    filtersDto['isCanTerm'] = false;
                    filtersDto['isPet'] = false;
                    filtersDto['floor'] = '0';
                    filtersDto['year'] = '0';
                    filtersDto['option'] = [];
                    break;
            }

            this.reset();
        });

        doFiltering();
    }

    function updateDtoModel(focus) {
        const key = focus.attr('name');
        let element = filtersDto[key];

        if (typeof element === 'object') {
            focus.is(":checked") ? // 이게 이상하게 반대로 작동함
                removeSpecifiedElement(filtersDto[key], filtersDto[key].indexOf(focus.val())) :
                filtersDto[key].push(focus.val())
        } else if (typeof element === 'boolean') {
            filtersDto[key] = !focus.is(":checked");
        } else if (focus.attr('name') === 'deposit') {
            filtersDto[key] = depositValues[focus.val()];
        } else if (focus.attr('name') === 'salePrice') {
            filtersDto[key] = salePriceValues[focus.val()];
        } else {
            filtersDto[key] = focus.val();
        }

        console.log(filtersDto);
        doFiltering();
    }

    function doFiltering() {
        let url = window.location.pathname;

        if (url.includes('maps')) {
            mapManager.eventTrigger();
        } else {
            // Do return filters offer;
            let offerPageInfo = getOffersByFilter();

            pageHelper.bindOffers(1, offerPageInfo);
            pageHelper.pageCalculation(1, offerPageInfo, (page) => {
                pageHelper.bindOffers(page, getOffersByFilter(page))
            });
        }
    }

    function set_array_slide_value(focus, valueArea, dataList) {
        let index = focus.val();
        let value = dataList[index];

        let size = dataList.length;
        let min = dataList[0];
        let max = dataList[size];

        if (value === min || value === max) {
            value = "무제한";
        } else if (value.length <= 4) {
            value = "~" + value + "만원"
        } else {
            value = "~" + (value / 10000) + "억";
        }

        valueArea.text(value);
    }

    function set_slide_value(focus, valueArea) {
        let value = focus.val();
        console.log(value);

        if (value === '0' || value === '105') {
            value = "무제한";
        } else if (value.toString().length <= 4) {
            value = "~" + value + "만원"
        } else {
            value = "~" + (value / 10000) + "억";
        }

        valueArea.text(value);
    }
</script>
