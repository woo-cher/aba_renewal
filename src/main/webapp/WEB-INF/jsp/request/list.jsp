<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>요청 매물 목록</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/web-resources/scss/offer_request_list.css">
        <link rel="stylesheet" type="text/css" href="/web-resources/scss/map/filter-bar.css">

        <script src="/web-resources/js/kakao/ajax/ajax-repository.js"></script>

        <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
    </head>

    <body>
        <div class="main-container">
            <div class="list-wrap">
                <div class="list-header">
                    <span class="list-title all">총
                        <label class="aba" id="how">${fn:length(requests)}</label>
                        명이 집을 찾고 있어요
                        <label class="aba">:)</label>
                    </span>

                    <p class="request-fixed">
                        <span class="aba request-label">우리집 추천해줘! :D</span>
                        <a href="/requests/create/form" class="request-btn"></a>
                    </p>
                </div>
                <%-- Filter area --%>
                <%@include file="/WEB-INF/jsp/request/filter.jsp"%>

                <ul class="list-table">
                    <c:choose>
                        <c:when test="${not empty requests}">
                            <c:forEach var="request" items="${requests}" varStatus="vs">
                                <li class="list-row" onclick="location.href='/requests/${request.id}'">
                                    <div class="request header">
                                        <span class="demand list-title">${request.demand}</span>
                                        <p class="moveIn">
                                            <c:choose>
                                                <c:when test="${fn:contains(request.moveIn, '.')}">
                                                    ${fn:substring(request.moveIn, 5, 10)}
                                                </c:when>
                                                <c:otherwise>
                                                    ${request.moveIn}
                                                </c:otherwise>
                                            </c:choose>
                                            입주
                                        </p>
                                    </div>
                                    <div class="request types">
                                        <c:forEach var="offerType" items="${request.offerTypeList}" varStatus="vs">
                                            <span>${offerType.value}<c:if test="${vs.index ne fn:length(request.offerTypeList) - 1}">,</c:if></span>
                                        </c:forEach>
                                    </div>
                                    <div class="request price">
                                        <p>
                                            <c:if test="${not empty request.deposit}">
                                                보증금 ${request.deposit}
                                            </c:if>
                                        </p>
                                        <p>
                                            <c:if test="${not empty request.monthlyDeposit}">
                                                보증금 ${request.monthlyDeposit}
                                            </c:if>
                                        </p>
                                        <p>
                                            <c:if test="${not empty request.monthlyPrice}">
                                                월세 ${request.monthlyPrice}
                                            </c:if>
                                        </p>
                                    </div>
                                    <div class="request required">
                            <span class="aba">
                                <c:forEach var="condition" items="${request.conditionTypeList}" varStatus="vs">
                                    <span class="condition"># ${condition.value}</span>
                                </c:forEach>
                            </span>
                                    </div>
                                    <div class="request info pt-3">
                                        <span class="info"><i class="aba txt-lg fas fa-arrows-alt"></i>${request.pyeong}</span>
                                        <span class="info"><i class="aba txt-lg fas fa-sort-numeric-up-alt"></i>${request.floor}</span>
                                        <span class="info"><i class="aba txt-lg fas fa-door-open"></i>${request.room}</span>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="w-full txt-lg aba pt-3 align-center">의뢰 목록이 없어요 :(</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        <div class="nav-m-b" id="listNavMobile"hidden>
            <a href="#" class="requestscreateform" class="active">
                <i class="fas fa-laptop-house"></i>
                <p>내집찾기</p>
            </a>
            <a href="#" class="requestsall">
                <i class="fas fa-laptop-house"></i>
                <p>요청매물목록</p>
            </a>
            <a href="#" class="requestsmycertified">
                <i class="fas fa-laptop-house"></i>
                <p>내요청서</p>
            </a>
        </div>
    </body>
</html>

<script>
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
                    content.style.maxHeight = "230";
                    content.style.border = "1px solid rgb(187, 187, 187)";
                    last = this;
                }
            });
        }
    });

    /**
     * jstl 의 ${var} 태그와, ES6 템플릿 리터럴 `${var}` 이 충돌나기 때문에,
     * ES6 템플릿 리터럴이 적용되지 않는다.
     *
     * 따라서, 이를 위해 `${ '${var}' }` 이렇게 사용함
     */
    function updateOfferRequests(requests) {
        let requestsArea = $('.list-table');
        let size = requests.length;

        requestsArea.empty();
        $('#how').text(size);

        if(size === 0) {
            requestsArea.append(`
                <li class="w-full txt-lg aba pt-3 align-center">의뢰 목록이 없어요 :(</li>
            `);

            return;
        }

        for(let i = 0; i < size; i++) {
            let req = requests[i];

            requestsArea.append(`
           <li class="list-row" onclick="location.href='/requests/${ '${req.id}' }'">
                <div class="request header">
                    <span class="demand list-title all">${ '${req.demand}' }</span>
                    <p class="moveIn">
                        ${ '${req.moveIn.includes(".") ? req.moveIn.substring(5, 10) : req.moveIn}' } 입주
                    </p>
                </div>

                <div class="request types" id="types${'${req.id}'}"></div>
                <div class="request price">
                    <p>
                        ${ '${req.deposit !== null ? "보증금 " + req.deposit : ""}' }
                    </p>
                    <p>
                        ${ '${req.monthlyDeposit !== null ? "보증금 " + req.monthlyDeposit : ""}' }
                    </p>
                    <p>
                        ${ '${req.monthlyPrice !== null ? "월세 " + req.monthlyPrice : ""}' }
                    </p>
                </div>
                <div class="request required">
                    <span class="aba" id="condition${'${req.id}'}"></span>
                </div>
                <div class="request info pt-3">
                    <span class="info"><i class="aba txt-lg fas fa-arrows-alt"></i>${'${req.pyeong}'}</span>
                    <span class="info"><i class="aba txt-lg fas fa-sort-numeric-up-alt"></i>${'${req.floor}'}</span>
                    <span class="info"><i class="aba txt-lg fas fa-door-open"></i>${'${req.room}'}</span>
                </div>
            </li>
            `);

            for(let i = 0; i < req.conditionTypeList.length; i++) {
                let type = req.conditionTypeList[i];

                $('#condition' + req.id).append(`
                   <span class="condition"># ${ '${type.value}' }</span>
                `)
            }

            for(let i = 0; i < req.offerTypeList.length; i++) {
                let type = req.offerTypeList[i];
                let size = req.offerTypeList.length;

                $('#types' + req.id).append(`
                    <span>${ '${type.value}' }${'${i !== size - 1 ? "," : ""}'}</span>
                `)
            }
        }
    }
</script>
