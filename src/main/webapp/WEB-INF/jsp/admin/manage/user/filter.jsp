<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .reset { position: absolute; right: 25px; top: 20px; font-size: 1rem !important; }
    .reset > i { cursor: pointer; }
    .reset > i:hover { zoom: 1.1; color: blueviolet !important; }
</style>

<div class="box-border over-hide admin-filter">
    <div class="filter-wrap w-full in-flex item-center box-border">
        <form class="category p-1 relative" id="user-type">
            <div class="reset f-c">
                <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
            </div>
            <p class="f-row">사용자 유형</p>
            <ul class="checkbox-container txt-sm p-1 w-max">
                <c:forEach var="userType" items="${userTypes}" begin="2" varStatus="vs">
                <li class="checkbox-list">
                    <input id="userType${vs.index}" type="checkbox" name="userTypes" value="${userType.code}" class="check">
                    <label for="userType${vs.index}" onclick="updateDtoModel($(this).prev())">
                        ${userType.value}
                    </label>
                </li>
                </c:forEach>
            </ul>
        </form>
        <form class="category p-1 relative" id="user-pay">
            <div class="reset f-c">
                <i class="fas fa-undo-alt aba" onclick="resetDtoValues($(this))"></i>
            </div>
            <p class="f-row">결제여부</p>
            <ul class="checkbox-container txt-sm p-1 w-max">
                <li class="checkbox-list">
                    <input id="none-payment" type="checkbox" name="" value="" class="check">
                    <label for="none-payment" onclick="serviceNotYet(event)">
                        비결제회원
                    </label>
                </li>
                <li class="checkbox-list">
                    <input id="payment" type="checkbox" name="" value="" class="check">
                    <label for="payment" onclick="serviceNotYet(event)">
                        결제회원
                    </label>
                </li>
            </ul>
        </form>
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
    let userFilterDto = {
        userTypes: [],
        isPay: false,
        page: Number(1)
    };

    function resetDtoValues(focus) {
        $(focus).parents('form').map(function () {
            let id = this.id;

            switch (id) {
                case 'user-type':
                    userFilterDto['userTypes'] = [];
                    break;
                case 'user-pay':
                    userFilterDto['isPay'] = false;
                    break;
            }

            this.reset();
        });

        doFiltering();
    }

    function updateDtoModel(focus) {
        const key = focus.attr('name');
        let element = userFilterDto[key];

        if(typeof element === 'object') {
            focus.is(":checked") ? // 이게 이상하게 반대로 작동함
                removeSpecifiedElement(userFilterDto[key], userFilterDto[key].indexOf(focus.val())) :
                userFilterDto[key].push(focus.val())
        } else if(typeof element === 'boolean') {
            userFilterDto[key] = !focus.is(":checked");
        } else {
            userFilterDto[key] = focus.val();
        }

        console.log(userFilterDto)

        doFiltering();
    }

    function doFiltering() {
        // Do filtering and data bind
        let userPageInfo = getUsersByFilter(userFilterDto);

        pageHelper.bindUsers(1, userPageInfo);
        pageHelper.pageCalculation(1, userPageInfo, (page) => {
            userFilterDto['page'] = page;
            pageHelper.bindUsers(1, getUsersByFilter(userFilterDto))
        });
    }
</script>
