<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>아바 포인트충전</title>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.1/css/all.css" crossorigin="anonymous">

    <%--`jquery` resrouce --%>
    <script src="/web-resources/js/jquery-1.7.2.min.js"></script>
    <script src="/web-resources/js/jquery-ui.min.js"></script>

    <script src="/web-resources/js/utils.js"></script>
    <script src="/web-resources/js/kakao/ajax/ajax-repository.js"></script>

    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

    <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">
    <link rel="stylesheet" type="text/css" href="/web-resources/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/web-resources/scss/payment.css">
</head>

<body>
    <div class="wrapper">
        <div class="price">
            <div class="price-header">
                <p class="header aba">희망 충전금액</p>
                <span class="caption">직접입력</span>
            </div>
            <div class="cash">
                <input type="text" id="amount" name="amount" placeholder="희망 금액을 입력하세요" onkeyup="convertWithCommas($(this))">
            </div>
            <div class="cash-status">
                <div class="before">
                    <p class="header">보유 포인트</p>
                    <span class="amount">0</span>
                </div>
                <div class="after">
                    <p class="header">충전 후 포인트</p>
                    <span class="amount">50,000</span>
                </div>
            </div>
        </div>
        <div class="payment">
            <div class="payment-header aba">결제수단</div>
            <div class="payment-wrapper">
                <div class="payment-ways">
                    <div class="header pay-method">
                        <i class="fas fa-arrow-alt-circle-right"></i>
                        카카오페이
                    </div>
                    <table class="ways">
                        <td>
                            <p class="pg-name">카카오페이</p>
                            <img src="/web-resources/img/pg/img_kakaopay.png">
                        </td>
                        <td onclick="serviceNotYet(event)">
                            <p class="pg-name">페이코</p>
                            <img src="/web-resources/img/pg/img_payco.png">
                        </td>
                        <td onclick="serviceNotYet(event)">
                            <img src="/web-resources/img/pg/img_toss_main.png">
                        </td>
                    </table>
                </div>
            </div>
            <button onclick="doPayment()">충전하기</button>
        </div>
    </div>
</body>

<script>
    let payment = {
        amount: $('#amount').val().replaceAll(',', ''),
        pg: 'kakao',
        method: 'kakaoPay',
        impId: null,
        merchantId: null
    };

    function convertWithCommas(focus) {
        let value = focus.val();

        value = value.replace(/[^0-9]/g,'');
        value = value.replace(/,/g,'');

        focus.val(value.replace(/\B(?=(\d{3})+(?!\d))/g, ","))
    }

    function doPayment() {
        let IMP = window.IMP;
        IMP.init('imp36032255');

        IMP.request_pay({ // param
            pg: 'kakao',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: '주문명 : 아바 포인트 충전',
            amount: $('#amount').val(),
            buyer_email: '${sessionUser.email}',
            buyer_name: '${sessionUser.name}',
            buyer_tel: '${sessionUser.phone}',
            buyer_addr: '${sessionUser.jibunAddr}',
            buyer_postcode: '${sessionUser.postCode}'
        }, function (rsp) { // callback
            if (rsp.success) {
                payment['amount'] = rsp.paid_amount;
                payment['impId'] = rsp.imp_uid;
                payment['merchantId'] = rsp.merchant_uid;

                onPaymentSuccess(payment);
            } else {
                alert(rsp.error_msg);
            }
            window.opener.location.reload();
            window.close();
        });
    }
</script>
