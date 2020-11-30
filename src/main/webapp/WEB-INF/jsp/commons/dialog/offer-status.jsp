<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="aba-dialog" id="status-dialog" title="매물 상태 변경" hidden>
    <li>
        <input type="hidden" value="ON">진행중
    </li>
    <li>
        <input type="hidden" value="OFF">미진행
    </li>
    <li>
        <input type="hidden" value="HIDE">숨김
    </li>
    <input type="hidden" class="target-id">
</div>

<script>
    $('#status-dialog > li').click(function () {
        let offerId = $('.target-id').val();
        let status = $(this).find('input').val();

        if(updateOfferStatus(offerId, status) === 0) {
            apiFailureAlert(this);
            return;
        }

        if (window.location.pathname.includes("offers_by_owner")) {
            let foldTarget = $('#owners > tr[class="checked"]').children().filter(':first-child');

            foldTarget.click().promise().done(function () {
                foldTarget.click();
            });
        } else {
            PageHelper.getActivePageElement().click();
        }

        dialogCloseTrigger($('.aba-dialog'));
    })
</script>
