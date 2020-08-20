<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>아바</title>

        <link rel="stylesheet" type="text/css" href="/scss/agree_view.css">

        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
    </head>

    <body>
    <div class="main-container">
            <!-- 공지사항 이름 & 전체보기 상자 -->
            <div class="main-header">
                <a class="prev" onclick="navigator(this, ${viewIndex})">
                    <img src="/img/basic/keyboard_arrow_left-24px.svg">
                </a>
                <a class="next" onclick="navigator(this, ${viewIndex})">
                    <img src="/img/basic/keyboard_arrow_right-24px.svg">
                </a>
                <div class="title">
                    <div class="line"></div>
                    <h2>
                        <c:choose>
                            <c:when test="${viewIndex eq 1}">
                                이용약관
                                <c:set var="path" value="/WEB-INF/jsp/agree/provision.jsp" />
                            </c:when>
                            <c:when test="${viewIndex eq 2}">
                                개인정보취급 방침
                                <c:set var="path" value="/WEB-INF/jsp/agree/personal_info.jsp" />
                            </c:when>
                            <c:when test="${viewIndex eq 3}">
                                위치기반서비스 이용약관
                                <c:set var="path" value="/WEB-INF/jsp/agree/location_based.jsp" />
                            </c:when>
                            <c:otherwise>
                                책임한계 및 법적고지
                                <c:set var="path" value="/WEB-INF/jsp/agree/responsibility.jsp" />
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </div>
            </div>

            <div class="main-content">
                <div class="content-wrap">
                    <c:import url="${path}" />
                </div>
            </div>
        </div>
    </body>
</html>

<script>
    $(document).ready(function() {
        var index = ${viewIndex};

        if(index === 1) {
            $(".prev").children().remove();
        }

        if(index === 4) {
            $(".next").children().remove();
        }
    });

    function navigator(focus, index) {
        if(focus.classList.contains("prev")) {
            index--;
            location.href = "/agree/" + index;
        } else {
            index++;
            location.href = "/agree/" + index;
        }
        console.log(index)
    }
</script>
