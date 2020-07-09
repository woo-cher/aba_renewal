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
                                <input id="offerType${vs.index}" type="checkbox" name="offerType" value="${vs.index}" class="check">
                                <label for="offerType${vs.index}">
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
                                    <input id="dealType${vs.index}" type="checkbox" name="dealType" value="${vs.index}" class="check">
                                    <label for="dealType${vs.index}">
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
                        <input type="range" min="0" max="20000" value="20000" step="10000" list="deposit-vals"
                               class="slider" id="deposit" onchange="set_slide_value(this, $('#deposit-val'))"
                        />
                        <datalist id="deposit-vals">
                            <option value="0">0</option>
                            <option value="10000" style="">1억</option>
                            <option value="-1" style="">∞</option>
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
                        <input type="range" min="0" max="105" value="105" step="5" list="monthly-vals"
                               class="slider" id="monthly" onchange="set_slide_value(this, $('#monthly-val'))"
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
            <a class="collapsible" href="#" style="cursor: not-allowed;" onclick="alert('준비중이예요 :)')">
                <i class="fas fa-sort-amount-down-alt fa-sm"></i>
                상세필터
            </a>
            <div class="filter-detail"></div>
        </li>
    </ul>
</div>

<script>
    var coll = document.getElementsByClassName("collapsible");
    var last;
    var i;

    for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
            if(last != undefined && last != this) {
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

    function set_slide_value(focus, value_area) {
        let value = focus.value;
        console.log(value);

        if (value === '0' || value === '20000' || value === '105') {
            value = "무제한";
        } else if (value.toString().length <= 3) {
            value = "~" + value + "만원"
        } else {
            value = "~" + (value / 10000) + "억";
        }

        value_area.text(value);
    }
</script>
