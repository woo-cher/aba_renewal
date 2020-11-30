<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="aba-dialog" id="status-dialog" title="매물 상태 변경" hidden>
    <li>진행중</li>
    <li>내리기</li>
    <li>숨김</li>
    <input type="hidden" class="target-id">
</div>

<script>
    $('#status-dialog > li').click(function () {
        let offerId = $('.target-id').val();

        // do update status and close

        dialogCloseTrigger($('.aba-dialog'));
    })
</script>
