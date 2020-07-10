<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
	<title>아바소개</title>
	<link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

	<link rel="stylesheet" type="text/css" href="/css/index.css">
	<link rel="stylesheet" type="text/css" href="/css/reset.css">
	<link rel="stylesheet" type="text/css" href="/css/index_%20responsive.css">
</head>

<body>
<%@include file="/WEB-INF/jsp/commons/header.jspf"%>

<div>
	<!-- 메인이미지 -->
	<section id="main_img">
		<div class="txt-box">
			<h3>
			공인중개사의 발품이 되어<br>
			편리함을 더하다
			</h3>
			<p>
			발로 뛰는 건 우리가 하고 손을 쓰는 건 공인중개사님이 하세요
			</p>
		</div>
	</section>

	<!-- 회사소개 -->
	<section id="contents01">
		<article class="txt_box">
			<h3>WHO WE ARE</h3>
			<div class="box_in">
				<img src="/img/aboutus_con1_img.png" alt="">
				<p>온라인 부동산시장에서 임대인의 부동산 매물정보를 정확하고 신속하게<br>
	파악하여 중개인분들에게 전달하며 부동산 계약성사률을 높여드리겠습니다
				</p>
			</div>
		</article>
		<article class="bg-img">
			<img src="/img/aboutus_con1.png" alt="bg">
		</article>
	</section>

	<!-- 회사연혁 -->
	<section id="history">
		<article class="in">
			<h3>OUR HISTORY</h3>
			<img src="/img/company_history.png" alt="" class="graph">
		</article>
		<article class="txt">
			<div class="txt01">
				<h4>2017.02</h4>
				<p>주식회사 아바 법인설립</p>
			</div>
			<div class="txt02">
				<h4>2017.09</h4>
				<p>아바시스템 중개인 Web오픈</p>
			</div>
			<div class="txt03">
				<h4>2018.03</h4>
				<p>아바시스템 일반인 Web오픈</p>
			</div>
		</article>
	</section>

	<!-- 아바서비스 -->
	<section id="service">
		<article class="service_in">
			<h3>OUR SERVICE</h3>
			<img src="/img/ourservice.png" alt="">
		</article>
		<article class="in_txt">
			<div class="txt01">
				<h5>No Work</h5>
				<p>당신이 원하는 매물을 찾기 위해 걷는 거리 매월 30km<br>
				ABA를 이용하기 위한 거리 40cm</p>
			</div>
			<div class="txt02">
				<h5>Too Fast</h5>
				<p>굳어버린 매물정보, 빠르게 흘러가는<br>
				매물정보 어떤 것을 선택하시겠습니까?</p>
			</div>
			<div class="txt03">
				<h5>So Cheap</h5>
				<p>매달 변동하는 매물 확보, 확인에 소모되는 자금을 버리고<br>
				저렴한 비용의 ABA를 선택하십시오</p>
			</div>
		</article>
	</section>

	<!-- contact -->
	<section id="contact">
		<article class="contact_in">
			<header class="head">
				CONTACT
			</header>
			<!-- 아바 회사 정보 -->
			<section class="info-box">
				<article class="text-box">
					<div class="box01">
						<img src="/img/contact_line.jpg" alt="">
						<h5>주소</h5>
						<p>경상남도 진주시 충무공동 87-23 드림it밸리 B동 807호</p>
					</div>
					<div class="box02">
						부동산 매물 공실 관리 문의 및 상담
					</div>
					<div class="box03">
						<ul>
							<li>
								<h5>TEL</h5>
								<p>055.748.9220</p>
							</li>
							<li>
								<h5>FAX</h5>
								<p>055.748.9221</p>
							</li>
							<li>
								<h5>E-mail</h5>
								<p>abasystem2017@gmail.com</p>
							</li>
						</ul>
					</div>
				</article>
				<!-- 아바 회사 지도 이미지 -->
				<article class="map">
					<img src="/img/contact_map.png" alt="">
				</article>
			</section>
		</article>
	</section>

	<%-- footer --%>
	<%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</div>
</body>
</html>
