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
        <div class="panel box f-c w-full pt-3 pb-1">
            <div class="frame avatar user-box">
                <p class="content">
                    <span class="txt-lg">아바</span> 님의 등급은
                    <span class="d-label">Diamond</span>
                    입니다.
                </p>
                <img class="w-65" src="/img/guide.jpg">
            </div>
            <div class="frame form-control p-0">
                <div class="input-group f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">아이디</span>
                    </div>
                    <input class="w-half" type="text" disabled value="abasystem">
                </div>
                <div class="input-group f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">이름</span>
                    </div>
                    <input class="w-half" type="text" disabled value="아바시스템">
                </div>
                <div class="input-group f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">연락처</span>
                    </div>
                    <input class="w-half" type="text" disabled value="010-1234-1234">
                </div>
                <div class="input-group f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">이메일</span>
                    </div>
                    <input class="w-half" type="text" disabled value="cs@abasystem.com">
                </div>
                <div class="input-group f-c">
                    <div class="form-label w-25 align-left">
                        <span class="form-label before w-full">인증서류</span>
                    </div>
                    <input class="w-half" type="text" disabled value="중개.pdf">
                </div>
                <div class="input-group p-0">
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
        <div class="panel box pt-1 pb-1">
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
            <div class="input-group f-c">
                <div class="form-label w-25">
                    <span class="form-label before w-full">새 비밀번호</span>
                </div>
                <input class="w-half" type="text">
            </div>
            <div class="input-group f-c">
                <div class="form-label w-25">
                    <span class="form-label before w-full">새 비밀번호 확인</span>
                </div>
                <input class="w-half" type="text">
            </div>
            <div class="input-group p-0">
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
        <div class="input-group p-0">
            <div class="panel box pt-1 pb-1">
                <div class="panel content box border-box">
                    <div class="frame" style="line-height: 1.75rem;">
                        <p>회원 탈퇴 시, <span class="aba">아바</span>에서 보관중인 모든 개인정보 및 활동내역이 삭제됩니다.</p>
                        <p>탈퇴에 동의하시게 되면, 계정을 되돌릴 수 없어요!</p>
                        <p>계속하시려면, 아래 <span class="aba">버튼</span>을 누르세요 <span class="aba">:)</span></p>
                    </div>
                </div>
            </div>
            <button class="btn inline txt-sm w-25" type="submit" onclick="isAgree()">탈퇴하기 :(</button>
        </div>
    </div>
</div>

<script>
    function isAgree() {
        if(confirm("회원탈퇴를 진행할까요?")) {
            return;
        } else {
            return;
        }
    }
    // $(document).ready(function () {
    //     $('#content-2th').html(getElement());
    //     $('#content-3th').html(getElement());
    // })
</script>
