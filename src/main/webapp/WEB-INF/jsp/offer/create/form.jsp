<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>아바 관리자모드</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/offer_create.css">
    <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">

    <script src="/web-resources/js/kakao/ajax/ajax-repository.js"></script>
    <script src="/web-resources/js/kakao/kakao-address.js"></script>
    <script src="/web-resources/js/validator.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>

    <%@include file="/WEB-INF/jsp/commons/admin_header.jspf"%>
</head>

<body>
    <div class="main-container p-1">
        <ul class="left-navbar" id="leftNav">
            <li class="nav-left active">기본정보</li>
            <li class="nav-left">주소정보</li>
            <li class="nav-left">추가정보</li>
        </ul>
        <div class="bottom-navbar prev" onclick="bottomNavigator(false)" hidden>
            <p class="nav-bottom aba txt-lg">
                <i class="fas fa-arrow-alt-circle-left"></i>
                Prev
            </p>
        </div>
        <div class="bottom-navbar next" onclick="bottomNavigator(true)">
            <p class="nav-bottom aba txt-lg">
                Next
                <i class="fas fa-arrow-alt-circle-right"></i>
            </p>
        </div>
        <div class="bottom-navbar submit" onclick="$('#submit').click()" hidden>
            <p class="nav-bottom aba txt-lg">
                등록하기
                <i class="fas fa-check-circle"></i>
            </p>
        </div>

        <article class="content-wrap">
            <div class="content-name" id="top">
                <h3>
                    <span class="aba">아바</span>
                    <span class="header mini">매물등록</span>
                </h3>
            </div>

            <form action="/offers/create" id="offerForm" method="post" enctype="multipart/form-data">
                <input type="submit" id="submit" hidden>
                <div id="formWrap">
                    <%@include file="/WEB-INF/jsp/offer/create/basics.jsp"%>
                    <%@include file="/WEB-INF/jsp/offer/create/addresses.jsp"%>
                    <%@include file="/WEB-INF/jsp/offer/create/additions.jsp"%>
                </div>
            </form>
        </article>
    </div>
</body>
</html>

<script>
    $(document).ready(function () {
        <c:if test="${not empty processIndex}">
            $('#leftNav').children().eq(${processIndex}).click();
        </c:if>

        <c:if test="${not empty errors}">
        $('.error').remove();
        let fieldName, errorMessage, selector;
            <c:forEach var="error" items="${errors}">
                fieldName = `${error.getField()}`;
                errorMessage = `${error.getDefaultMessage()}`;
                selector = $('input[name="' + fieldName + '"]').parents('.check-area');
                selector.addClass('invalid b-1r');
                selector.find('.error-box').append(
                    '<p class="error" style="margin-bottom: 2px;">' +
                    '<i class="fas fa-exclamation-circle">' +
                    '</i>' + errorMessage + '</p>'
                );
            </c:forEach>
        </c:if>
    });

    Dropzone.options.dropzone = {
        url: '/aws/s3/upload',
        autoProcessQueue: false,
        uploadMultiple: true,
        addRemoveLinks: true,
        maxFiles: 8,
        thumbnailWidth: 100,
        thumbnailHeight: 100,
        acceptedFiles: 'image/*',
        addedfiles: function (file) {
            $('.dz-progress').remove();
            $('.dz-image').css('width', 100);
            $('.dz-image').css('height', 100);
            $('.dz-remove').html(`<i class='fas fa-minus-circle' style="cursor: pointer;"></i>`)
            $('.dz-remove').css('margin-top', 10);

            $("#files")[0].files = file;
        }
    };

    $('#leftNav > li').click(function(e) {
        let navIndex = $(e.currentTarget).index();
        console.log(navIndex);

        if(navIndex === 0) {
            $('.prev').hide();
            $('.submit').hide();
            $('.next').show();
        } else if(navIndex === 2) {
            $('.next').hide();
            $('.submit').show();
        } else {
            $('.prev').show();
            $('.next').show();
            $('.submit').hide();
        }
    });

    function findNavIndex() {
        let nav = $('#leftNav > li');

        for(let i = 0; i < nav.length; i++) {
            if($(nav[i]).hasClass('active')) {
                return $(nav[i]).index();
            }
        }
    }

    function bottomNavigator(isNext) {
        let selector = $('#leftNav');

        if(findNavIndex() === selector.children('li').length) {
            return;
        }

        let dom = $("#completionYear")[0]
        console.log($("#completionYear")[0].checkValidity());

        if(!dom.checkValidity()) {
            dom.setCustomValidity("라뉘")
        }

        if(isNext) {
            $('#leftNav').children().eq(findNavIndex() + 1).click();
        } else if(findNavIndex() !== 0){
            $('#leftNav').children().eq(findNavIndex() - 1).click();
        }
    }

    function dongTrigger(dong) {
        if(dong.prop('disabled')) {
            dong.prop('disabled', false);
            dong.val('');
        } else {
            dong.prop('disabled', true);
            dong.val('동 정보 없음');
        }
    }

    function floorTrigger() {
        let isFloorUp = $('#floorUp').prop('checked');
        let selector = $('#floor');

        let hoInput = $('#ho');

        selector.prop('readonly', !isFloorUp);

        if($('#floorUnder').prop('checked')) {
            hoInput.val('반지하');
            hoInput.hide();
            hoInput.next().hide();
            selector.val('반지하');
        } else if($('#floorTop').prop('checked')) {
            hoInput.val('옥탑');
            hoInput.hide();
            hoInput.next().hide();
            selector.val('옥탑');
        } else {
            hoInput.val('');
            hoInput.show();
            hoInput.next().show();

            selector.val('');
            selector.prop('placeholder', '예) 3층')
        }
    }

    function noneAction(focus) {
        let bool = focus.css('background-color') === 'rgb(0, 173, 239)';
        bool ? focus.css('background', 'red') : focus.css('background', '#00adef');
        focus.prev('input').prop('disabled', bool);
        focus.prev('input').val('없음');
    }

    function elevatorTrigger(focus) {
        let isChecked = focus.prop('checked');

        console.log(isChecked);

        isChecked ? $('#manage5').parent().show() : $('#manage5').parent().hide();
        $('#manage5').prop('checked', false);
    }

    function dynamicFormTrigger(focus) {
        let elementId = focus.attr('id');
        let target;

        if(elementId === 'tenant') {
            target = $('#tenantDesc');
            target.toggle();
            target.css('display') === 'none' ? target.find('input').val('무') : target.find('input').val('');
        } else {
            target = $('#howTerm');
            target.toggle();
            target.css('display') === 'none' ? target.find('input').val('0') : target.find('input').val('');
        }
    }

    function booleanHelper(focus) {
        let isChecked = focus.prop('checked');
        focus.val(isChecked);
    }

    activateWithSelector('#leftNav > li');
    switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');
</script>
