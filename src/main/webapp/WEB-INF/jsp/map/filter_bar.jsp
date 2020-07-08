<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="filter-bar">
    <ul class="filter-group">
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-home fa-sm"></i>
                매물분류
            </a>
            <div class="filter-detail">
                <div class="detail-container">
                    <header class="detail-header">
                        <p class="title">매물분류</p>
                        <p class="caption">중복선택이 가능해요 :)</p>
                    </header>

                    <ul class="checkbox-container">
                        <li class="checkbox-list">
                            <input id="category1" type="checkbox" name="category" value="" class="check">
                            <label for="category1">
                                원룸
                            </label>
                        </li>
                    </ul>
                </div>
            </div>
        </li>
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-handshake fa-sm"></i>
                거래유형
            </a>
            <div class="filter-detail">ggg</div>
        </li>
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-hand-holding-usd fa-sm"></i>
                보증금
            </a>
            <div class="filter-detail">ggg</div>
        </li>
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-money-bill-alt fa-sm"></i>
                관리비
            </a>
            <div class="filter-detail">ggg</div>
        </li>
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-calendar-alt fa-sm"></i>
                준공년도
            </a>
            <div class="filter-detail">ggg</div>
        </li>
        <li class="filter-el">
            <a class="collapsible" href="#">
                <i class="fas fa-sort-amount-down-alt fa-sm"></i>
                상세필터
            </a>
            <div class="filter-detail">ggg</div>
        </li>
    </ul>
</div>

<script>
    var coll = document.getElementsByClassName("collapsible");
    var i;

    for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var content = this.nextElementSibling;

            if (content.style.maxHeight){
                content.style.maxHeight = null;
                content.style.border = null;
            } else {
                content.style.maxHeight = "100%";
                content.style.border = "1px solid rgb(187, 187, 187)";
            }
        });
    }
</script>
