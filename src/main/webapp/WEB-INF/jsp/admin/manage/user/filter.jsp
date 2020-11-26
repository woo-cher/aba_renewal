<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="box-border over-hide admin-filter">
    <div class="filter-wrap w-full in-flex item-center box-border">
        <div class="category p-1">
            <p class="f-row">사용자 유형</p>
            <ul class="checkbox-container txt-sm p-1 w-max">
                <c:forEach var="userType" items="${userTypes}" begin="2" varStatus="vs">
                <li class="checkbox-list">
                    <input id="userType${vs.index}" type="checkbox" name="userType" value="${userType.code}" class="check" checked>
                    <label for="userType${vs.index}" onclick="">
                        ${userType.value}
                    </label>
                </li>
                </c:forEach>
            </ul>
        </div>
        <div class="category p-1">
            <p class="f-row">결제여부</p>
            <ul class="checkbox-container txt-sm p-1 w-max">
                <li class="checkbox-list">
                    <input id="none-payment" type="checkbox" name="" value="" class="check" checked>
                    <label for="none-payment" onclick="">
                        비결제회원
                    </label>
                </li>
                <li class="checkbox-list">
                    <input id="payment" type="checkbox" name="" value="" class="check" checked>
                    <label for="payment" onclick="">
                        결제회원
                    </label>
                </li>
            </ul>
        </div>
<%--        <div class="category p-1">--%>
<%--            <p class="f-row">회원 등급</p>--%>
<%--            <ul class="checkbox-container txt-sm p-1 w-max">--%>
<%--                <li class="checkbox-list">--%>
<%--                    <input id="a" type="checkbox" name="offerType" value="TWO_THREE_ROOM" class="check" checked>--%>
<%--                    <label for="a" onclick="updateDtoModel($(this).prev())">--%>
<%--                        브론즈--%>
<%--                    </label>--%>
<%--                </li>--%>
<%--                <li class="checkbox-list">--%>
<%--                    <input id="b" type="checkbox" name="offerType" value="TWO_THREE_ROOM" class="check" checked>--%>
<%--                    <label for="b" onclick="updateDtoModel($(this).prev())">--%>
<%--                        실버--%>
<%--                    </label>--%>
<%--                </li>--%>
<%--            </ul>--%>
<%--        </div>--%>
    </div>
</div>

<script>
    
</script>
