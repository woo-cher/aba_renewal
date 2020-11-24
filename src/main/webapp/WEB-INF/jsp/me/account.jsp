<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="content-left">
    <div class="panel left-wrap">
        <ul id="nav" class="nav-bar-col">
            <li class="txt-md active">회원정보</li>
            <li class="txt-md">비밀번호 변경</li>
            <li class="txt-md">회원탈퇴</li>
        </ul>
    </div>
</div>

<div class="content-right">
    <div class="panel pt-1 right-wrap">
        <div class="content label">
            <div class="label-wrap">회원정보</div>
        </div>
        <div class="panel f-c w-full pt-3 pb-1">
            <div class="frame avatar user-box">
                <p class="content">
                    <span class="txt-lg">아바</span> 님의 등급은
                    <span class="d-label">Diamond</span>
                    입니다.
                </p>
                <img class="w-65" src="/web-resources/img/guide.jpg">
            </div>
            <div class="frame form-control p-0">
                <div class="input-group w-full f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">아이디</span>
                    </div>
                    <input class="w-half" type="text" disabled value="${sessionUser.userId}">
                </div>
                <div class="input-group w-full f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">이름</span>
                    </div>
                    <input class="w-half" type="text" disabled value="${sessionUser.name}">
                </div>
                <div class="input-group w-full f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">연락처</span>
                    </div>
                    <input class="w-half" type="text" disabled value="${sessionUser.phone}">
                </div>
                <div class="input-group w-full f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">이메일</span>
                    </div>
                    <input class="w-half" type="text" disabled value="${sessionUser.email}">
                </div>
                <div class="input-group w-full f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">인증서류</span>
                    </div>
                    <input class="w-half" type="text" disabled value="준비중입니다 :)">
                </div>
                <div class="input-group w-full p-0">
                    <div class="box-left"></div>
                    <div class="box-right">
                        <button class="btn inline txt-sm" type="submit">서류보기</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="content label pt-1">
            <div class="label-wrap">소개</div>
        </div>
        <div class="panel pt-1 pb-1">
            <div class="panel content box border-box">
                <div class="frame">
                    안녕하세요.홍길동입니다. 저 다이아 등급입니다.
                </div>
            </div>
        </div>
    </div>

    <div class="panel pt-1 right-wrap" id="content-2th" hidden>
        <div class="content label">
            <div class="label-wrap">비밀번호 변경</div>
        </div>
        <form class="frame form-control p-0">
            <div class="input-group w-full f-c">
                <div class="form-label w-25">
                    <span class="form-label before w-full">현재 비밀번호</span>
                </div>
                <input class="w-half" type="text">
            </div>
            <div class="input-group w-full f-c">
                <div class="form-label w-25">
                    <span class="form-label before w-full">새 비밀번호</span>
                </div>
                <input class="w-half" type="text">
            </div>
            <div class="input-group w-full f-c">
                <div class="form-label w-25">
                    <span class="form-label before w-full">새 비밀번호 확인</span>
                </div>
                <input class="w-half" type="text">
            </div>
            <div class="input-group w-full p-0">
                <div class="box-left"></div>
                <div class="box-right">
                    <button class="btn inline txt-sm" type="submit">변경하기</button>
                </div>
            </div>
        </form>
    </div>

    <div class="panel pt-1 right-wrap" id="content-3th" hidden>
        <div class="content label">
            <div class="label-wrap">회원탈퇴</div>
        </div>
        <div class="input-group w-full p-0">
            <div class="panel pt-1 pb-1">
                <div class="panel content border-box">
                    <div class="frame" style="line-height: 1.75rem;">
                        <p>회원 탈퇴 시, <span class="aba">아바</span>에서 보관중인 모든 개인정보 및 활동내역이 삭제됩니다.</p>
                        <p>탈퇴에 동의하시게 되면, 계정을 되돌릴 수 없어요!</p>
                        <p>계속하시려면, 아래 <span class="aba">버튼</span>을 누르세요 <span class="aba">:)</span></p>
                    </div>
                </div>
            </div>
            <button class="btn inline txt-sm w-25" type="submit"
                    onclick="dialogInitializer($(this), $('#password-dialog'), null, '${sessionUser.userId}')">탈퇴하기 :(</button>
        </div>
    </div>

    <div class="aba-dialog" id="password-dialog" title="아바" hidden>
        <div class="dialog-ask">
            <p class="aba target"></p>
            <p>비밀번호 인증이 필요합니다 :)</p>
        </div>
        <div class="dialog-ask">
            <input type="password" class="w-75" id="password">
            <div class="error pt-3" hidden></div>
        </div>
        <div class="dialog-btn-group pt-3">
            <button class="fl w-45" type="button" onclick="withdrawal($('#password').val())">제출</button>
            <input type="hidden" class="target-id">
            <button class="fr w-45" type="button" onclick="dialogCloseTrigger($('#password-dialog'))">취소</button>
        </div>
    </div>
</div>

<style>
    .ui-dialog {
        z-index: 3 !important;
    }
</style>

<script>
    function withdrawal(inputPassword) {
        // Do certified input password with sessionUser's password

        let isValid = isValidPassword(inputPassword);
        let errorBox = $('.error');

        if(!isValid) {
            errorBox.empty();
            errorBox.show();

            $('#password').addClass('invalid b-1r');
            errorBox.addClass('invalid');

            errorBox.append(`
               <i class="fas fa-exclamation-circle"></i>
               <span>비밀번호가 일치하지 않네요 :(</span>
            `);

            errorBox.effect('shake', { distance : 3, time: 1 }, 100);
        } else {
            location.href = "/auth/logout";
            deleteUserById($('.target-id').val());
        }
    }
</script>
