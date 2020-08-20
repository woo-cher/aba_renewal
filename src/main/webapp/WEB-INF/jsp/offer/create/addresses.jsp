<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="form-control mt-0" hidden>
    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>소재지</span>
    </div>
    <div class="input-group">
        <input autofocus readonly type="text" class="middle" id="jibun" placeholder="지번주소" name="offerAddress.jibun">
        <p class="short">/</p>
        <input autofocus readonly type="text" class="middle" id="road" placeholder="도로명주소" name="offerAddress.road">
        <p class="icon addr" onclick="getAddress()"><i class="fas fa-search"></i></p>
    </div>

    <div class="input-group">
        <input type="text" class="middle" placeholder="예) 아바아파트, 아바빌, 아바빌딩" name="offerAddress.buildingName">
        <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
    </div>

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>호실 정보</span>
    </div>
    <div class="input-group">
        <input type="hidden" id="latitude" name="offerAddress.latitude">
        <input type="hidden" id="longitude" name="offerAddress.longitude">
        <input type="text" class="short" placeholder="예) 3동" name="offerAddress.dong" id="dong">
        <p class="icon"><i class="fas">동</i></p>
        <p class="short"></p>
        <input type="text" class="short" placeholder="예) 401호" name="offerAddress.ho">
        <p class="icon"><i class="fas">호</i></p>
    </div>
    <ul class="checkbox-container p-0 w-half">
        <li class="checkbox-list w-65">
            <input type="checkbox" class="check" id="isExistDong"
                   onclick="dongTrigger($('#dong'))"
            >
            <label for="isExistDong">등본에 동 정보가 없습니다</label>
        </li>
    </ul>

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>해당층</span>
    </div>
    <div class="input-group">
        <ul class="checkbox-container p-0 w-half">
            <li class="checkbox-list w-25">
                <input type="radio" class="check" id="floorUp" name="none" checked
                       onchange="floorTrigger()"
                >
                <label for="floorUp">지상</label>
            </li>
            <li class="checkbox-list w-25">
                <input type="radio" class="check" id="floorUnder" name="none"
                       onchange="floorTrigger()"
                >
                <label for="floorUnder">반지하</label>
            </li>
            <li class="checkbox-list w-25">
                <input type="radio" class="check" id="floorTop" name="none"
                       onchange="floorTrigger()"
                >
                <label for="floorTop">옥탑방</label>
            </li>
        </ul>
        <input type="text" class="short" placeholder="예) 3층" name="offerAddress.floor" id="floor">
        <p class="icon"><i class="fas">층</i></p>
    </div>

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>입구 / 호실 비밀번호</span>
    </div>
    <div class="input-group">
        <input type="text" class="short" placeholder="123* 또는 전화문의" name="offerAddress.entrance" id="entrance">
        <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
        <p class="short">/</p>
        <input type="text" class="short" placeholder="1234* 또는 전화문의" name="offerAddress.door" id="door">
        <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
    </div>

    <div class="form-label">
        <i class="fas fa-circle"></i>
        <span>주요 위치</span>
    </div>
    <div class="input-group">
        <input type="text" class="short" placeholder="아바경찰서" name="offerAddress.nearLocation">
        <p class="icon"><i class="fas">부근</i></p>
    </div>
</section>
