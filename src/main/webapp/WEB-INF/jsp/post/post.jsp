<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>공지사항</title>
        <link rel="icon" type="image/png" sizes="16x16" href="/web-resources/img/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/web-resources/scss/post.css">
        <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/form.css">
        <link rel="stylesheet" type="text/css" href="/web-resources/scss/component/paginator.css">

        <script src="/web-resources/js/page-helper.js"></script>

        <%@include file="/WEB-INF/jsp/commons/header.jspf"%>

        <style>
            .main-container {
                height: calc(100% - 70px);
            }
        </style>
    </head>

    <body>
        <div class="main-container pt-3">
            <!-- 공지사항이름 & 전체보기 상자 -->
            <div class="post-header">
                <div class="title">
                    <div class="line"></div>
                    <h2>공지사항</h2>
                </div>
            </div>

            <div class="post-filter">
                <div class="relative w-65 m-auto pt-3 pb-3">
                    <div class="w-full align-right" style="right: 5%;">
                    <c:if test="${sessionUser.role eq 'MASTER'}">
                        <span class="aba txt-sm mr-1">게시글 등록하기 :)</span>
                        <a href="/posts/form" class="add-btn"></a>
                    </c:if>
                    </div>
                </div>
<%--                <div class="filter-wrap pt-3">--%>
<%--                    <select>--%>
<%--                        <option>전체</option>--%>
<%--                        <option>인사말</option>--%>
<%--                        <option>업데이트</option>--%>
<%--                        <option>정기점검</option>--%>
<%--                    </select>--%>
<%--                    <p>--%>
<%--                        <span>검색 구분</span>--%>
<%--                    </p>--%>
<%--                    <select>--%>
<%--                        <option>전체</option>--%>
<%--                        <option>제목</option>--%>
<%--                        <option>내용</option>--%>
<%--                    </select>--%>
<%--                    <input type="text" placeholder="검색어를 입력하세요" class="search-box">--%>
<%--                    <button class="button">--%>
<%--                        <img src="/web-resources/img/notice_search-01.png" alt="">--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>

            <!-- 표 -->
            <section id="table">
                <table>
                    <thead>
                        <tr>
                            <th width="10%" scope="col">번호</th>
                            <th width="40%" scope="col">제목</th>
                            <th width="10%" scope="col">작성자</th>
                            <th width="10%" scope="col">등록일</th>
                            <th width="10%" scope="col">조회</th>
                            <c:if test="${sessionUser.role eq 'MASTER'}">
                            <th width="20%" scope="col"></th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody id="posts"></tbody>
                </table>

                <div class="page-num p-1">
                    <div class="paginator b-0 p-0">
                        <div class="page-wrap f-c">
                            <button class="page prev p-0" onclick="onPrevOrNext(pageHelper.startPage - 5)">
                                <img src="/web-resources/img/basic/keyboard_arrow_left-24px.svg">
                            </button>
                            <ul class="pages" style="display: contents;">
                                <li class="active">1</li>
                            </ul>
                            <button class="page prev p-0" onclick="onPrevOrNext(pageHelper.startPage + 5)">
                                <img src="/web-resources/img/basic/keyboard_arrow_right-24px.svg">
                            </button>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <!-- footer -->
    <%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
    </body>
</html>

<style>
    table { border-spacing: 0; }

    tr:hover { background: aliceblue; }

    p.td02 {
        display: inline-block;
        border: 0;
        padding: 0;
        width: 80%;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    i:hover { color: #00adef; }
</style>

<script src="/web-resources/js/paginator/post-paginator.js"></script>
<script>
    let pageHelper = new PostPaginator(5, $('#posts'));
    $(document).ready(function () {
        let pageInfo = getPosts(pageHelper.startPage);

        pageHelper.setEndPage(pageInfo['pages']);
        pageHelper.bindPosts(1, pageInfo);
        pageHelper.pageCalculation(1, pageInfo, (page) => {
            pageHelper.bindPosts(page, getPosts(page));
        });

        <c:if test="${sessionUser.role ne 'MASTER'}">
            $(".management").remove();
        </c:if>
    });

    function onPrevOrNext(pageParam) {
        pageHelper.prevOrNext(pageParam, () => {
            let pageInfo = getPosts(pageParam);

            pageHelper.bindPosts(pageParam, pageInfo);
            pageHelper.pageCalculation(pageParam, pageInfo, (page) => {
                pageHelper.bindPosts(page, getPosts(page))
            });
        })
    }

    function doDelete(id) {
        if(confirm("게시글을 삭제할까요?")) {
            $('#post' + id).remove();
            deletePost(id);
        } else {
            return;
        }
    }
</script>
