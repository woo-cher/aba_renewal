<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/login.css">
</head>
<body>

<div id="wrap">

    <header id="header"></header>
    <section id="contents">
        <article id="con-box">
            <header class="login-name">
                <h3>회원 로그인</h3>
            </header>
            <section class="box">
                <form class="id-pw" action="/auth/doLogin" method="post">
                    <label>
                        <input type="text" class="id" placeholder="아이디" name="username">
                    </label>
                    <label>
                        <input type="password" class="pw" placeholder="비밀번호" name="password">
                    </label>
                    <div class="check-box">
                        <input type="checkbox" class="login-save" name="" value="save">&nbsp; 아이디 저장
                        <input type="checkbox" class="auto-login" name="" value="auto">&nbsp; 자동로그인
                    </div>
                    <button class="login-button" type="submit">로그인</button>
                </form>
                <div class="nav-box">
                    <div class="join">
                        아직도 회원이 아니신가요?
                        <button>회원가입&nbsp;&nbsp;&nbsp;&nbsp;></button>
                    </div>
                    <div class="find">
                        아이디/비밀번호를 잊으셨나요?
                        <button class="id-find">아이디 찾기 ></button>
                        <button class="pw-find">비밀번호 찾기 ></button>
                    </div>
                </div>
            </section>
        </article>
    </section>
    <footer id="footer"></footer>
</div>

</body>
</html>
