<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>매물 찾아주세요!</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">

    <script src="/web-resources/js/validator.js"></script>

    <%@include file="/WEB-INF/jsp/commons/tempory_header.jspf"%>
</head>

<body>
    <div class="main-container">
        <article class="content-wrap">
            <div class="content-name" id="top">
                <h3>
                    <span class="aba">나의</span>
                    <span class="header mini">요청매물</span>
                </h3>
            </div>

            <form action="/requests/my" method="post">
                <div id="formWrap">
                    <section class="form-control mt-0 mb-0">
                        <div class="form-warp mb-0">
                            <div class="form-label pt-3">
                                <i class="fas fa-circle"></i>
                                <span>등록한 전화번호를 입력해주세요!</span>
                            </div>
                            <div class="input-group">
                                <input required type="text" class="short" placeholder="연락처" name="phone"
                                       pattern="^[0-9]{1,4}"
                                       oninvalid="this.setCustomValidity(`숫자를 입력해주세요 :)`)"
                                       oninput="this.setCustomValidity(''); this.checkValidity()"
                                       onkeyup="formValidatorWithRegex($(this))"
                                >
                                <p class="short">-</p>
                                <input required type="text" class="short" placeholder="####" name="phone"
                                       pattern="^[0-9]{4}"
                                       oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                       oninput="this.setCustomValidity(''); this.checkValidity()"
                                       onkeyup="formValidatorWithRegex($(this), 'phone')"
                                >
                                <p class="short">-</p>
                                <input required type="text" class="short" placeholder="####" name="phone"
                                       pattern="^[0-9]{4}"
                                       oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                       oninput="this.setCustomValidity(''); this.checkValidity()"
                                       onkeyup="formValidatorWithRegex($(this), 'phone')"
                                >
                            </div>
                            <div class="form-control">
                                <p class="error w-half" style="margin: 0 auto !important;" hidden>
                                    <i class="fas fa-exclamation-circle" id="error"></i>
                                </p>
                            </div>
                            <button type="submit" class="login-button w-35 fr">제출</button>
                        </div>
                    </section>
                </div>
            </form>
        </article>
    </div>
</body>
</html>

<script>
    switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');
</script>
