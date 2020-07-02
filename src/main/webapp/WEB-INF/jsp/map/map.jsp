<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>매물찾기</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <script type="text/javascript" src="/js/kakao/kakao-map.js"></script>
</head>
<body>
    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>

    <div id="map" style="width:500px;height:400px;"></div>
</body>
</html>

<script>
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };

    var map = new kakao.maps.Map(container, options);
</script>
