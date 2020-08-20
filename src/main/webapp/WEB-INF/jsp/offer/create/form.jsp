<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>아바 관리자모드</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/component/form.css">
    <link rel="stylesheet" type="text/css" href="/scss/offer_create.css">
    <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
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
        <div class="bottom-navbar submit" hidden>
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

            <form action="/offers/create" method="post" enctype="multipart/form-data" onsubmit="return false;">
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

<script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
<script>
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

        if(navIndex === 0) {
            $('.prev').hide();
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

        if(isNext) {
            $('#leftNav').children().eq(findNavIndex() + 1).click();
        } else if(findNavIndex() !== 0){
            $('#leftNav').children().eq(findNavIndex() - 1).click();
        }
    }

    function dongTrigger(selector) {
        selector.prop('readonly', !selector.prop('readonly'));
    }

    function floorTrigger() {
        let isFloorUp = $('#floorUp').prop('checked');
        let selector = $('#floor');

        selector.prop('readonly', !isFloorUp)

        if($('#floorUnder').prop('checked')) {
            selector.prop('placeholder', '반지하')
        } else if($('#floorTop').prop('checked')) {
            selector.prop('placeholder', '옥탑방')
        } else {
            selector.prop('placeholder', '예) 3층')
        }
    }

    function noneAction(focus) {
        let bool = focus.css('background-color') === 'rgb(0, 173, 239)';
        bool ? focus.css('background', 'red') : focus.css('background', '#00adef');
        focus.prev('input').prop('readonly', bool)
    }

    function elevatorTrigger(focus) {
        let isChecked = focus.prop('checked');

        console.log(isChecked);

        isChecked ? $('#manage5').parent().show() : $('#manage5').parent().hide();
        $('#manage5').prop('checked', false);
    }

    function dynamicFormTrigger(focus) {
        let elementId = focus.attr('id');

        console.log(elementId);

        elementId === 'tenant' ? $('#tenantDesc').toggle() : $('#howTerm').toggle();
    }

    activateWithSelector('#leftNav > li');
    switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');
</script>
