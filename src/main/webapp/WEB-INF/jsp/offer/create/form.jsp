<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>아바 매물등록</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/offer_create.css">
    <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">

    <script src="/web-resources/js/kakao/ajax/ajax-repository.js"></script>
    <script src="/web-resources/js/kakao/kakao-address.js"></script>
    <script src="/web-resources/js/validator.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>

<c:choose>
    <c:when test="${isUpdate}">
        <c:set var="actionUrl" value="/offers/update" />
    </c:when>
    <c:otherwise>
        <c:set var="actionUrl" value="/offers/create" />
    </c:otherwise>
</c:choose>

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
        <div class="bottom-navbar submit" onclick="doSubmit()" hidden>
            <p class="nav-bottom aba txt-lg">
            <c:choose>
                <c:when test="${isUpdate}">매물수정</c:when>
                <c:otherwise>등록하기</c:otherwise>
            </c:choose>
                <i class="fas fa-check-circle"></i>
            </p>
        </div>

        <article class="content-wrap" style="width: 750px;">
            <div class="content-name" id="top">
                <h3>
                    <span class="aba">아바</span>
                    <span class="header mini">매물등록</span>
                </h3>
            </div>

            <form id="offerForm" action="${actionUrl}" method="post" enctype="multipart/form-data">
                <input type="submit" id="submit" hidden>
                <input type="hidden" id="post">
                <input type="hidden" name="status" value="ON">
                <c:if test="${isUpdate}">
                    <input type="hidden" name="id" value="${offer.id}">
                    <input type="hidden" name="offerAddress.offerId" value="${offer.id}">
                    <input type="hidden" name="offerAddition.offerId" value="${offer.id}">
                    <input type="hidden" name="file[]">
                </c:if>
                <input type="hidden" id="thumbnail" name="thumbnail" value="${fn:split(offer.thumbnail, "/")[1]}">
                <input type="hidden" name="user.userId" value="${sessionUser.userId}">
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
        if (window.opener !== null) {
            $('header').remove();
        }

        activateWithSelector('#leftNav > li');
        switchContentViewWithIndex('#leftNav > li', '.form-control', '#formWrap');

        showLoader();
        leftNavEventListener();
        dynamicFormEventListener();

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

        <c:if test="${!isUpdate}">
            $('#thumbTrigger').attr('style', 'display:none !important');
        </c:if>

        <c:if test="${isUpdate}">
            <c:if test="${offer.offerAddress.floor eq -1}">
                $('#floorUnder').click();
                $('#floor').val('반지하');
            </c:if>
            <c:if test="${offer.offerAddress.floor eq 100}">
                $('#floorTop').click();
                $('#floor').val('옥탑');
            </c:if>
            <c:if test="${offer.offerAddress.entrance eq '없음'}">
                $('#entrance').next('.icon-with-check').click();
            </c:if>
            <c:if test="${offer.offerAddress.door eq '없음'}">
                $('#door').next('.icon-with-check').click();
            </c:if>
            <c:if test="${offer.offerAddress.dong eq null}">
                $('#isExistDong').prop('checked', true);
                dongTrigger($('#dong'));
            </c:if>
            <c:if test="${offer.offerAddition.tenant ne '무'}">
                $("#tenant").prop('checked', true);
                dynamicFormTrigger($('#tenant'));
                $('#tenantDesc').find('input').val("${offer.offerAddition.tenant}")
            </c:if>
            <c:if test="${offer.offerAddition.term ne 0}">
                $('#term').prop('checked', true);
                dynamicFormTrigger($('#term'));
                $('#howTerm').find('input').val("${offer.offerAddition.term}")
            </c:if>
            <c:if test="${offer.offerAddition.hasElevator}">
                $('#elevator').prop('checked', true);
                elevatorTrigger($('#elevator'))
                $('#manage5').prop('checked', true);
            </c:if>
            <c:if test="${offer.offerAddition.canParking}">
                $('#parking').prop('checked', true);
            </c:if>
            <c:if test="${offer.offerAddition.canPet}">
                $('#pet').prop('checked', true);
            </c:if>
        </c:if>
    });

    Dropzone.options.abaDropzone = {
        url: '${actionUrl}',
        paramName: 'files',
        autoProcessQueue: false,
        uploadMultiple: true,
        addRemoveLinks: true,
        parallelUploads: 8,
        maxFiles: 20,
        thumbnailWidth: 100,
        thumbnailHeight: 100,
        acceptedFiles: 'image/*',
        resizeWidth: 780,
        resizeHeight: 520,
        init: function () {
            let fileCountOnServer = ${fn:length(offer.imageUrls)};
            let dropZone = this;

            function thumbDesignationTrigger() {
                if(dropZone.files.length > 1) {
                    $('#thumbTrigger').show();
                } else {
                    $('#thumbTrigger').hide();
                }
            }

            this.on('complete', function (file) {
                $('.dz-remove').html(`<i class='fas fa-minus-circle' style="cursor: pointer;"></i>`);
                $('.dz-remove').css('margin-top', 10);
                $('.dz-image').css('width', 100);
                $('.dz-image').css('height', 100);

                <c:if test="${!isUpdate}">
                    thumbDesignationTrigger();
                </c:if>
            });

            <c:if test="${!isUpdate}">
                this.on('thumbnail', function (file, dataUrl) {
                    $('#thumbnail').val(dropZone.files[0].name);

                    let thumbElement = getThumbnailElement();
                    thumbElement.addClass('offer-thumbnail');
                    thumbElement.append(getDelegateMarkElement());
                });
            </c:if>

            this.on("sendingmultiple", function(file, xhr, formData) {
                $('form').serializeArray().map(function (entry) {
                    formData.append(entry.name, entry.value);
                });

                dropZone.emit('complete', file);
            });

            this.on("successmultiple", function (file, responseText) {
                location.href = "/users/me/my_offer";
            });

            this.on("removedfile", function (file) {
                thumbDesignationTrigger();
            });

            $('#submit').click(function (e) {
                if(dropZone.files.length === 0) {
                    // nothing
                }  else {
                    e.preventDefault();
                    dropZone.processQueue();
                }
            });

            dropZone.options.maxFiles = this.options.maxFiles - fileCountOnServer;

            <c:if test="${isUpdate}">
                <c:forEach var="keyValueDto" items="${offer.imageUrls}" varStatus="vs">
                    var fileName = '${keyValueDto.key}';
                    var url = '${keyValueDto.url}';
                    var mockFile = { name: fileName, size: 1000, type: 'image/png' };

                    this.emit("addedfile", mockFile);
                    this.emit("thumbnail", mockFile, url);
                    this.emit("complete", mockFile);

                    $(mockFile.previewElement).append(getThumbSelectBtnElement(fileName));
                </c:forEach>

                var thumbElement = getThumbnailElement();

                thumbElement.addClass('offer-thumbnail');
                thumbElement.append(getDelegateMarkElement());
            </c:if>
        },
        addedfiles: function (file) {
            for(let i = 0; i < file.length; i++) {
                $(file[i].previewElement).append(getThumbSelectBtnElement(file[i].name));
            }
            this.emit('complete', file);
        },
        <c:if test="${isUpdate}">
        removedfile: function (file) {
            if(file.accepted === undefined) { // isMockFile
                if(confirm("이미지를 삭제할까요?")) {
                    deleteImage('${offer.id}', file.name);
                    this.options.maxFiles++;
                }
            }

            file.previewElement.remove();
        }
        </c:if>
    };

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

        let dom = $("#completionYear")[0];
        console.log(dom.checkValidity());

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
            hoInput.prop('readonly', true);
            selector.val('반지하');
        } else if($('#floorTop').prop('checked')) {
            hoInput.val('옥탑');
            hoInput.prop('readonly', true);
            selector.val('옥탑');
        } else {
            hoInput.val('');
            hoInput.prop('readonly', false);

            selector.val('');
            selector.prop('placeholder', '예) 3층')
        }
    }

    function noneAction(focus) {
        let bool = focus.css('background-color') === 'rgb(0, 173, 239)';
        bool ? focus.css('background', 'red') : focus.css('background', '#00adef');
        focus.prev('input').prop('readonly', bool);
        focus.prev('input').val('없음');
    }

    function elevatorTrigger(focus) {
        let isChecked = focus.prop('checked');

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
            target.css('display') === 'none' ? target.find('input').val(null) : target.find('input').val('');
        }
    }

    function booleanHelper(focus) {
        let isChecked = focus.prop('checked');
        focus.val(isChecked);
    }

    function getThumbSelectBtnElement(fileName) {
        return `
            <div class="thumb-label select c-pointer" style="z-index: 10;" onclick="setThumbnail($(this), getThumbnailElement())" hidden>
                선택
                <input type="hidden" value="${'${fileName}'}">
            </div>
        `;
    }
    
    function getDelegateMarkElement() {
        return `<div class="thumb-label thumbnail" style="z-index: 10;">대표</div>`;
    }

    function getThumbnailElement() {
        var thumbFileName = $('#thumbnail').val();
        return $('img[alt="' + thumbFileName + '"]').parent().parent();
    }

    function setThumbnailTrigger() {
        $('.select').toggle();
        $('.thumb-message').toggle();
    }

    function setThumbnail(focus, thumbNailElement) {
        let thumbnail = focus.find('input').val();
        let newThumbnailElement = focus.parent('.dz-preview');

        thumbNailElement.removeClass('offer-thumbnail');
        thumbNailElement.find('.thumbnail').remove();

        newThumbnailElement.addClass('offer-thumbnail');
        newThumbnailElement.append(getDelegateMarkElement());

        $('#thumbnail').val(thumbnail);
    }

    function doSubmit() {
        $('#submit').click();
        window.opener.close();
    }

    function leftNavEventListener() {
        $('#leftNav > li').click(function(e) {
            let navIndex = $(e.currentTarget).index();
            // console.log(navIndex);

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
    }

    function dynamicFormEventListener() {
        $('input[name="dealType"]').on("change", function (e) {
            dynamicConverter()
        });

        $('input[name="type"]').on("change", function (e) {
            dynamicConverter()
        });
    }

    function dynamicConverter() {
        let dealType = $('input[name="dealType"]:checked').prop('value');
        let offerType = $('input[name="type"]:checked').prop('value');

        let normalSaleEl = $('.normal-sale');
        let normalRentalEl = $('.normal-rental');
        let noneAptField = $('.none-apt');
        let aptField = $('.apt');
        let officeEl = $('.office-type');

        let isRoomType = ['ONE_ROOM', 'TWO_THREE_ROOM'].includes(offerType);
        let isOfficeType = ['SHOP', 'OFFICE'].includes(offerType);
        let isAptType = ['APT', 'EFFICIENCY_APT'].includes(offerType);

        if (isAptType) {
            $('#remodeling').removeClass('hidden');
            $('#term-box').addClass('hidden');
            $('.total-floor').removeClass('hidden');
            $('.floor-box').addClass('hidden');
            $('.apt-area').removeClass('hidden');
        } else {
            $('#remodeling').addClass('hidden');
            $('#term-box').removeClass('hidden');
            $('.total-floor').addClass('hidden');
            $('.floor-box').removeClass('hidden');
            $('.apt-area').addClass('hidden');
        }

        if (dealType === 'SALE') {
            normalSaleEl.removeClass('hidden');
            normalRentalEl.addClass('hidden');
            officeEl.addClass('hidden');

            $('.total-floor').removeClass('hidden');
            $('.floor-box').addClass('hidden');
            $('input[value="TWO_THREE_ROOM"]').parent().hide();

            $('#deposit').prop('placeholder', '총 보증금');
            $('#monthlyPrice').prop('placeholder', '월 임대총액');

            if (isOfficeType || isAptType) {
                $('.dong-ho-box').removeClass('hidden');
            } else {
                $('.dong-ho-box').addClass('hidden');
            }

            if (offerType !== 'APT' && offerType !== 'EFFICIENCY_APT') {
                $('#profit').removeClass('hidden');
                noneAptField.removeClass('hidden');
                aptField.addClass('hidden');
            } else {
                $('#profit').addClass('hidden');
                $('.dong-ho-box').remove('hidden');
                noneAptField.addClass('hidden');
                aptField.removeClass('hidden');
            }
        } else {
            normalRentalEl.removeClass('hidden');
            normalSaleEl.addClass('hidden');

            $('input[value="TWO_THREE_ROOM"]').parent().show();

            isRoomType ? $('.room-type').removeClass('hidden') : $('.room-type').addClass('hidden');
            isOfficeType ? officeEl.removeClass('hidden') : officeEl.addClass('hidden');

            $('#deposit').prop('placeholder', '보증금');
            $('#monthlyPrice').prop('placeholder', '월 가격');
        }
    }
</script>
