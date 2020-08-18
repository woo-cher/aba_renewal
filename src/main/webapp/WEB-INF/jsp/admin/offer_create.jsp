<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>아바 관리자모드</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/component/form.css">
    <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>
<body>
    <div class="main-container">
        <article class="content-wrap">
            <div class="content-name" id="top">
                <h3>
                    <span class="aba">아바</span>
                    <span class="header mini">매물등록</span>
                </h3>
            </div>

            <section class="form-control" id="register-area">
                <form action="/aws/s3/upload" method="post" enctype="multipart/form-data" onsubmit="return test();">
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>기본항목</span>
                    </div>
                    <div class="form-category" hidden>
                        <div class="input-group">
                            <input type="text" id="userId" class="middle" name="">
                            <p class="icon"><i class="fas fa-user-check"></i></p>
                        </div>
                        <input type="password" placeholder="비밀번호" id="password" name="">
                        <input type="text" placeholder="닉네임" name="">
                    </div>
                </div>

                <div id="dropzone" class="dropzone align-center">
                    <div class="dz-default dz-message">
                        <img src="/img/offer/add_image.png">
                        <p class="aba pt-3">사진을 끌어다 놓거나 눌러서 업로드 해주세요 :)</p>
                    </div>
                    <input type="hidden" name="offerIdForDirectory" value="1234"/>
                    <input hidden type="file" id="files" name="files" multiple />
                </div>
                <div class="pt-1">
                    <button class="login-button" type="submit">등록하기</button>
                </div>
                </form>
            </section>
        </article>
    </div>
</body>
</html>

<script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
<script>
    // $(document).on("dragover drop", function(e) {
    //     e.preventDefault();  // allow dropping and don't navigate to file on drop
    // }).on("drop", function(e) {
    //     $("input[type='file']")
    //         .prop("files", e.originalEvent.dataTransfer.files)  // put files into element
    //         .closest("form")
    //         .submit();  // autosubmit as well
    // });

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
            // $('.dz-success-mark').remove();
            $('.dz-image').css('width', 100);
            $('.dz-image').css('height', 100);
            $('.dz-remove').html(`<i class='fas fa-minus-circle' style="cursor: pointer;"></i>`)
            $('.dz-remove').css('margin-top', 10);

            $("#files")[0].files = file;
        }
    };

    function test() {
        return true;
    }
</script>
