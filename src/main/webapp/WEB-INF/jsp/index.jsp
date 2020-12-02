<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<title>아바</title>
	<link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

	<link rel="stylesheet" type="text/css" href="/web-resources/css/main.css">
	<link rel="stylesheet" type="text/css" href="/web-resources/css/main1492px.css">
	<link rel="stylesheet" type="text/css" href="/web-resources/css/main_mobile.css">

	<%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>

<body>
	<div class="main-container p-0">
		<!-- 메인이미지 -->
		<section id="main_img" class="over-hide">
			<div class="mobile-txt">
				<img src="/web-resources/img/mobile_bg_txt.png" alt="">
			</div>
			<div class="find-home-box" onmouseenter="$(this).effect('shake', { distance : 2, time: 1 }, 100);">
				<a href="/requests/create/form" class="find-home c-pointer">
					우리집 찾아주세요!
					<img src="/web-resources/img/basic/keyboard_arrow_right-24px.svg">
				</a>
			</div>
			<form id="search" onsubmit="return false">
					<div class="form-control">
						<label>
							<input type="text" class="search-box" name="keyword"
								   placeholder="원하시는 지역별 혹은 매물을 검색해보세요"
								   onkeypress="watchEnterAction(event.keyCode)"
							>
						</label>
						<button type="button" class="button" onclick="navigateMapWithKeyword(keyword.value)">
							<img src="/web-resources/img/notice_search-01.png">
						</button>
					</div>
			</form>
		</section>

		<!-- 사이드 바
		<section id="side">
			<article class="side-bar">
				<div class="side-cart">
					<a href="#">
						<strong>찜한 매물</strong>
						<em class="cart_count">0</em>
					</a>
				</div>
				<div class="recently-viewed-product">
					<a href="#">
						<strong>최근 본 매물</strong>
						<em class="total_element">0</em>
					</a>
				</div>
				<div class="recently-viewed-list">
					<ul>
						<li>
							최근 본 매물이<br>
							없습니다
						</li>
					</ul>
				</div>
			</article>

		</section>

		<aside id="sidebar">
			<ul class="bar-view">
				<li class="btn1">
					<a href="#">찜한 매물&nbsp;&nbsp;▶</a>
				</li>
				<li class="btn2">
					<a href="#">오늘 본 매물</a>
				</li>
				<li class="btn3">
					오늘 본 매물이 없습니다
				</li>
			</ul>
		</aside>

		아바서치 -->
		<section id="contents1">

		<!-- 아바서치 컨텐츠 -->
			<article id="con_in">

			<!-- 왼쪽 텍스트-->
			<article class="txt">
				<div class="line"></div>
				<h3>ABA SEARCH</h3>
				<p class="leading-2d5">각 테마별로 원하시는<br>매물을 검색해보세요!</p>
				 <div class="btn c-pointer" onclick="location.href='/guide'">
					<a>이용가이드</a>
				 </div>
			</article>

			<!-- 이미지 -->
			<article class="img">
				<div class="img01">
					<a href="#">
					   <img src="/web-resources/img/contents1_img01.jpg" alt="진행중매물" class="in01">

					</a>
					<a href="#">
						<img src="/web-resources/img/contents1_hover.png" alt="" class="in02">
					</a>
				</div>
				<div class="img02">
					<a href="#">
						<img src="/web-resources/img/contents1_img02.jpg" alt="급매물" class="in01">
					</a>
					<a href="#">
						<img src="/web-resources/img/contents1_hover.png" alt="" class="in02">
					</a>
				</div>
				<div class="img03">
					<a href="#">
						<img src="/web-resources/img/contents1_img03.jpg" alt="모든 매물" class="in01">
					</a>
					<a href="#">
						<img src="/web-resources/img/contents1_hover.png" alt="" class="in02">
					</a>
				</div>
				<div class="img04">
					<a href="#">
						<img src="/web-resources/img/contents1_img04.jpg" alt="집주인 매물등록" class="in01">
					</a>
					<a href="#">
						<img src="/web-resources/img/contents1_hover.png" alt="" class="in02">
					</a>
				</div>
			 </article>
			</article>
		</section>

		<!-- 아바서치 모바일 -->
		<section id="contents1-mobile">

			<!-- 아바서치 컨텐츠 -->
			<article id="con_in_mobile">

				<!--타이틀 및 텍스트-->
				<article class="top">
					<div class="left">
						<div class="line"></div>
						<h3>ABA SEARCH</h3>
						<p>각 테마별로 원하시는 매물을 검색해보세요!</p>
					</div>
					<div class="btn">
						<a href="#">매물전체보기</a>
					</div>
				</article>
				<!-- 이미지 -->
				<article class="mobile-img">
					<div class="img-box">
						<a href="#"><img src="/web-resources/img/contents1_img01.jpg" alt="진행중매물"></a>
						<a href="#"><img src="/web-resources/img/contents1_img02.jpg" alt="급매물"></a>
						<a href="#"><img src="/web-resources/img/contents1_img03.jpg" alt="모든 매물"></a>
						<a href="#"><img src="/web-resources/img/contents1_img04.jpg" alt="집주인 매물등록"></a>
					</div>
				</article>
			</article>
		</section>

		<!-- 공지사항&고객센터 -->
		<section id="contents2">
			<!-- 공지사항 -->
			<article class="notice">
				<h3>
					<img src="/web-resources/img/notice.png" alt="공지사항">
				</h3>
				<div class="btn">
					<a href="/posts">더보기 +</a>
				</div>

				<ul class="txt">
					<c:forEach var="post" items="${posts}" end="3">
					<li class="txt01" onclick="location.href='/posts/${post.id}'">
						<a>${post.title}</a>
					</li>
					</c:forEach>
				</ul>
			</article>

			<!-- 고객센터 -->
			<article class="cs">
				<div class="title">
					<img src="/web-resources/img/cs.png" alt="고객센터">
				</div>
				<div class="info">
					<img src="/web-resources/img/contents2_cs.png" alt="고객센터 정보">
				</div>
			</article>
		</section>

		<!-- 공지사항 모바일 -->
		<section id="notice-mobile">
			<article class="notice-in">
				<div class="top">
					<div class="top-line"></div>
					<h2>공지사항</h2>
					<div class="top-btn">
						+ 더보기
					</div>
				</div>
				<ul class="con-box">
					<li>
						<a href="notice_sub.html">아바에서 일반인도 볼 수 있는 페이지가 베타 오픈했습니다..</a>
					</li>
					<li>
						<a href="notice_sub.html">아바가 경남도민일보에 기사가 나왔습니다. 감사합니다..</a>
					</li>
					<li>
						<a href="notice_sub.html">공인중개사를 위한 최고의 솔루션 "부동산매물 정보제공 업체"..</a>
					</li>
				</ul>
			</article>
		</section>

		<!-- 고객센터 모바일 -->
		<section id="cs-mobile">
			<article class="cs-in">
				<div class="top">
					<div class="top-line"></div>
					<h2>고객센터</h2>
				</div>
				<div class="call">
					<img src="/web-resources/img/contents2_cs.png" alt="고객센터 정보">
				</div>

			</article>
		</section>

	</div>
	<!-- footer -->
	<%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</body>
</html>

<script src="/web-resources/js/main.js"></script>
<script>
	function navigateMapWithKeyword(keyword) {
		if(keyword === '' || keyword === ' ') {
			location.href = '/maps'
		} else {
			location.href = '/maps?keyword=' + keyword;
		}
	}

	function watchEnterAction(pressed) {
		if(pressed === 13) {
			$('#search').find('button').click();
		}
	}
</script>
