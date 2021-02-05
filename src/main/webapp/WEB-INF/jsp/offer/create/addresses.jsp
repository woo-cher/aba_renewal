<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="form-control mt-0" hidden>
    <div class="form-label relative">
        <i class="fas fa-circle"></i>
        <span class="required">소재지</span>
        <div class="error-box"></div>
    </div>

    <div class="input-group p-1 check-area">
        <input autofocus readonly type="text" class="middle" id="jibun" placeholder="지번주소" name="offerAddress.jibun" value="${offer.offerAddress.jibun}">
        <p class="short">/</p>
        <input autofocus readonly type="text" class="middle" id="road" placeholder="도로명주소" name="offerAddress.road" value="${offer.offerAddress.road}">
        <p class="icon addr" onclick="getAddress()"><i class="fas fa-search"></i></p>
    </div>

    <div class="input-group p-1 check-area">
        <input type="text" class="middle" placeholder="예) 아바아파트, 아바빌, 아바빌딩" name="offerAddress.buildingName" value="${offer.offerAddress.buildingName}"
               pattern="^[가-힣A-Za-z0-9() ]{1,15}" onkeyup="formValidatorWithRegex($(this))">
        <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
        <p class="short"></p>

        <input type="text" class="short total-floor hidden" placeholder="전체층" name="offerAddress.floor" value="${offer.offerAddress.floor}"
               pattern="^[0-9]{1,2}" onkeyup="formValidatorWithRegex($(this))">
        <p class="icon total-floor hidden"><i class="fas">층</i></p>
    </div>

    <div class="apt hidden">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>세대 및 동 정보</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="short" placeholder="총 세대수" name="OfferAddition.households" value="${offer.offerAddition.households}"
                   pattern="^[0-9]{1,4}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">세대</i></p>
            <p class="short"></p>

            <input type="text" class="short" placeholder="총 동수" name="OfferAddition.totalDong" value="${offer.offerAddition.totalDong}"
                   pattern="^[0-9]{1,4}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">개</i></p>
            <p class="short"></p>

            <input type="text" class="short" placeholder="총 주차수" name="OfferAddition.totalParking" value="${offer.offerAddition.totalParking}"
                   pattern="^[0-9]{1,3}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">대</i></p>
        </div>
    </div>

    <input type="hidden" id="latitude" name="offerAddress.latitude" value="${offer.offerAddress.latitude}">
    <input type="hidden" id="longitude" name="offerAddress.longitude" value="${offer.offerAddress.longitude}">

    <div class="dong-ho-box">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span class="required">호실 정보</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <p class="icon"><i class="fas">동</i></p>
            <input type="text" class="short" placeholder="예) 3동" name="offerAddress.dong" id="dong" value="${offer.offerAddress.dong}"
                   pattern="^[0-9]{1,4}" onkeyup="formValidatorWithRegex($(this))">
            <p class="short"></p>
            <p class="icon"><i class="fas">호실</i></p>
            <input type="text" class="middle" id="ho" placeholder="예) 102호, 103호" name="offerAddress.ho" value="${offer.offerAddress.ho}"
                   pattern="^[0-9, 호]{1,20}" onkeyup="formValidatorWithRegex($(this))">
        </div>
        <ul class="checkbox-container p-0 w-half">
            <li class="checkbox-list w-65">
                <input type="checkbox" class="check" id="isExistDong" onclick="dongTrigger($('#dong'))">
                <label for="isExistDong">동 정보가 없습니다</label>
            </li>
        </ul>
    </div>

    <div class="floor-box">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>해당층</span>
        </div>
        <div class="input-group p-1 check-area">
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
            <input type="text" class="short" placeholder="예) 3" name="offerAddress.floor" id="floor" value="${offer.offerAddress.floor}"
                   pattern="^[0-9]{1,2}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">층</i></p>
        </div>

        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>입구 / 호실 비밀번호</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="short" placeholder="123* 또는 전화문의" name="offerAddress.entrance" id="entrance" value="${offer.offerAddress.entrance}"
                   pattern="^[가-힣#*0-9]{1,8}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
            <p class="short">/</p>
            <input type="text" class="short" placeholder="1234* 또는 전화문의" name="offerAddress.door" id="door" value="${offer.offerAddress.door}"
                   pattern="^[가-힣#*0-9]{1,8}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon-with-check" onclick="noneAction($(this))"><i class="fas">없음</i></p>
        </div>
    </div>

    <div class="apt hidden">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>아파트 면적 정보 (공급면적 / 전용면적)</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="short" placeholder="예) 745.1" name="offerAddress.landArea" value="${offer.offerAddress.landArea}"
                   pattern="^[0-9.]{1,4}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">㎡</i></p>
            <p class="short">/</p>
            <input type="text" class="short" placeholder="예) 539" name="offerAddress.buildingArea" value="${offer.offerAddress.buildingArea}"
                   pattern="^[0-9.]{1,4}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">㎡</i></p>
        </div>
    </div>

    <div class="normal-sale none-apt hidden">
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span>면적정보 (건물 연면적 / 대지 면적)</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="short" placeholder="예) 745.1" name="offerAddress.buildingArea" value="${offer.offerAddress.buildingArea}"
                   pattern="^[0-9.]{1,4}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">㎡</i></p>
            <p class="short">/</p>
            <input type="text" class="short" placeholder="예) 539" name="offerAddress.landArea" value="${offer.offerAddress.landArea}"
                   pattern="^[0-9.]{1,4}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">㎡</i></p>
        </div>

        <div class="none-apt">
            <div class="form-label relative">
                <i class="fas fa-circle"></i>
                <span>세대정보</span>
                <div class="error-box"></div>
            </div>

            <div class="check-area">
                <div class="input-group p-1">
                    <input type="text" class="short" placeholder="지하세대" name="offerAddition.householdInfo" value="${households[0]}">
                    <p class="short">/</p>
                    <input type="text" class="short" placeholder="1층세대" name="offerAddition.householdInfo" value=${households[1]}>
                    <p class="short">/</p>
                    <input type="text" class="short" placeholder="2층세대" name="offerAddition.householdInfo" value=${households[2]}>
                </div>

                <div class="input-group p-1">
                    <input type="text" class="short" placeholder="3층세대" name="offerAddition.householdInfo" value=${households[3]}>
                    <p class="short">/</p>
                    <input type="text" class="short" placeholder="4층세대" name="offerAddition.householdInfo" value=${households[4]}>
                    <p class="short">/</p>
                    <input type="text" class="short" placeholder="5층세대" name="offerAddition.householdInfo" value=${households[5]}>
                    <p class="short">/</p>
                    <input type="text" class="short" placeholder="6층세대" name="offerAddition.householdInfo" value=${households[6]}>
                </div>
            </div>
        </div>
    </div>

    <div>
        <div class="form-label relative">
            <i class="fas fa-circle"></i>
            <span class="required">주요 위치</span>
            <div class="error-box"></div>
        </div>
        <div class="input-group p-1 check-area">
            <input type="text" class="short" placeholder="예) 아바경찰서" name="offerAddress.nearLocation" value="${offer.offerAddress.nearLocation}"
                   pattern="^[가-힣 ]{1,7}" onkeyup="formValidatorWithRegex($(this))">
            <p class="icon"><i class="fas">부근</i></p>
        </div>
    </div>
</section>
