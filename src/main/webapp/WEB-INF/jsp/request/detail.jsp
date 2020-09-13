<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>의뢰매물</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/web-resources/css/post_detail.css">

        <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
    </head>

    <body>
    <div class="main-container">
            <section id="notice-con">
                <article class="contents">
                   <header class="head">
                       <div class="line"></div>
                       <h2>의뢰매물</h2>
                   </header>
                    <section class="con-in">
                        <article class="in01">
                            <h4>[매물찾아요]
                                <span style="float: right; padding-right: 3.5%; font-size: 1rem;">
                                    <i class="fas fa-eye"></i>
                                    ${request.hits}
                                </span>
                            </h4>
                            <h3>${request.demand}</h3>
                            <p>${fn:substring(request.createdAt, 0, 16)}</p>
                        </article>
                        <article class="in02">
                            <p class="title-desc">원하는 거래유형</p>
                            <p>${request.dealType.value}</p>
                            <p class="title-desc">예산</p>
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
                            <p class="title-desc">원하는 주거유형</p>
                            <c:forEach var="offerType" items="${request.offerTypeList}" varStatus="vs">
                                <span>${offerType.value}</span><c:if test="${vs.index ne fn:length(request.offerTypeList) - 1}">,</c:if>
                            </c:forEach>
                            <p class="title-desc">희망 이사날짜</p>
                            <p>${request.moveIn}</p>
                            <p class="title-desc">필요한 방 갯수</p>
                            <p>방 ${request.room}</p>
                            <p class="title-desc">원하는 평형</p>
                            <p>${request.pyeong}</p>
                            <p class="title-desc">선호하는 지역</p>
                            <p>${request.location}</p>
                            <p class="title-desc">필수 고려조건</p>
                            <c:forEach var="condition" items="${request.conditionTypeList}" varStatus="vs">
                                <span class="condition">${condition.value}</span>
                            </c:forEach>
                            <p class="title-desc">제안 받을 연락처</p>
                            <p>${request.phone}</p>
                        </article>
                        <article class="back-btn">
                            <a href="javascript:window.history.back();">
                                <img src="/web-resources/img/notice_back_btn.png" alt="">
                            </a>
                        </article>
                    </section>
                </article>
            </section>
        </div>

        <!-- footer -->
        <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
    </body>
</html>
