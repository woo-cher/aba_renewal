<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>요청 매물 목록</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/web-resources/scss/offer_request_list.css">

        <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
    </head>

    <body>
        <div class="main-container">
            <div class="list-wrap">
                <div class="list-header">
                    <span class="list-title">총
                        <label class="aba">${fn:length(requests)}</label>
                        명이 집을 찾고 있어요
                        <label class="aba">:)</label>
                    </span>
                    <p class="request-fixed">
                        <span class="aba request-label">우리집 추천해줘! :D</span>
                        <a href="/requests/create/form" class="request-btn"></a>
                    </p>
                </div>

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
                                                전세보증금 ${request.deposit}
                                            </c:if>
                                        </p>
                                        <p>
                                            <c:if test="${not empty request.monthlyDeposit}">
                                                월세보증금 ${request.monthlyDeposit}
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
    </body>
</html>
