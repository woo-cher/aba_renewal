<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>공지사항</title>

        <link rel="stylesheet" type="text/css" href="/web-resources/scss/post.css">
        <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">

        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
    </head>

    <body>
        <div class="main-container">
            <!-- 공지사항이름 & 전체보기 상자 -->
            <div class="post-header">
                <div class="title">
                    <div class="line"></div>
                    <h2>공지사항</h2>
                </div>
            </div>

            <div class="post-filter">
                <div class="relative w-65 m-auto pt-3">
                    <div class="absolute w-full align-right" style="right: 5%;">
                    <c:if test="${sessionUser.role eq 'MASTER'}">
                        <span class="aba txt-sm mr-1">게시글 등록하기 :)</span>
                        <a href="/posts/form" class="add-btn"></a>
                    </c:if>
                    </div>
                </div>
                <div class="filter-wrap pt-3">
                    <select>
                        <option>전체</option>
                        <option>인사말</option>
                        <option>업데이트</option>
                        <option>정기점검</option>
                    </select>
                    <p>
                        <span>검색 구분</span>
                    </p>
                    <select>
                        <option>전체</option>
                        <option>제목</option>
                        <option>내용</option>
                    </select>
                    <input type="text" placeholder="검색어를 입력하세요" class="search-box">
                    <button class="button">
                        <img src="/web-resources/img/notice_search-01.png" alt="">
                    </button>
                </div>
            </div>

            <!-- 표 -->
            <section id="table">
                <table>
                    <colgroup>
                        <col style="width:100px">
                        <col>
                        <col style="width:140px">
                        <col style="width:110px">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">등록일</th>
                            <th scope="col">조회</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="notice">[공지]</td>
                            <td>
                                <a href="/posts/1" class="td02">아바에서 일반인도 볼 수 있는 페이지가 베타 오픈했습니다..</a>
                            </td>
                            <td>아바</td>
                            <td>2018.03.27</td>
                            <td>1314</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>
                                <a href="/posts/1" class="td02">아바가 경남도민일보에 기사가 나왔습니다. 감사합니다..</a>
                            </td>
                            <td>아바</td>
                            <td>2018.09.11</td>
                            <td>710</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>
                                <a href="/posts/1" class="td02">공인중개사를 위한 최고의 솔루션 “부동산 매물 정..</a>
                            </td>
                            <td>아바</td>
                            <td>2017.09.08</td>
                            <td>2663</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>
                                <a href="/posts/1" class="td02">아바 베타서비스 오픈기념 뮤료 사용기간 2017년 9..</a>
                            </td>
                            <td>아바</td>
                            <td>2017.08.21</td>
                            <td>1997</td>
                        </tr>
                    </tbody>
                </table>

                <div class="page-num">
                    <a href="#" class="num" style="font-size:1.75rem; font-weight: 700;">
                        1
                    </a>
                </div>

            </section>
        </div>

    <!--모바일-->
    <div id="mobile">
        <section id="mobile-header">
            <article class="header-in">
                <a href="#" class="back-btn">
                    <img src="/web-resources/img/notice_mobile_btn.png" alt="뒤로가기 버튼">
                </a>
                <h3>공지사항</h3>
            </article>

        </section>
        <section id="mobile-nav">
            <article class="filter">
                <div class="box01">
                    <select>
                        <option>전체</option>
                        <option>인사말</option>
                        <option>업데이트</option>
                        <option>정기점검</option>
                    </select>
                </div>
                <div class="box02">
                    <p>검색 구분</p>
                    <select>
                        <option>전체</option>
                        <option>제목</option>
                        <option>내용</option>
                    </select>
                    <div class="search">
                        <input type="text" placeholder="검색어를 입력하세요" class="search-box">
                        <button class="button">
                            <img src="/web-resources/img/notice_search-01.png" alt="">
                        </button>
                    </div>
                </div>
            </article>
        </section>

        <!-- 표 -->
        <section id="mobile-table">
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:50%">
                    <col style="width:15%">
                </colgroup>
                <!-- 첫번째줄 -->
                <tr>
                    <td scope="col">[공지]</td>
                    <td scope="col>
                        <a href="/posts/1" class="td02">아바에서 일반인도 볼 수 있는 페이지가 베타 오픈했습니다..</a>
                    </td>
                    <td scope="col">2018.03.27</td>
                </tr>
                <!-- 두번째줄 -->
                <tr>
                    <td>3</td>
                    <td>
                        <a href="/posts/1" class="td02">아바가 경남도민일보에 기사가 나왔습니다. 감사합니다..</a>
                    </td>
                    <td>2018.09.11</td>
                </tr>
                <!-- 세번째줄 -->
                <tr>
                    <td>2</td>
                    <td>
                        <a href="/posts/1" class="td02">공인중개사를 위한 최고의 솔루션 “부동산 매물 정..</a>
                    </td>
                    <td>2017.09.08</td>
                </tr>
                <!-- 네번째줄 -->
                <tr>
                    <td>1</td>
                    <td>
                        <a href="/posts/1" class="td02">아바 베타서비스 오픈기념 뮤료 사용기간 2017년 9..</a>
                    </td>
                    <td>2017.08.21</td>
                </tr>
            </table>

            <div class="page-num">
                <a href="#" class="num" style="font-size:1.75rem; font-weight: 700;">
                    1
                </a>
            </div>
        </section>
    </div>

    <!-- footer -->
    <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
    </body>
</html>
