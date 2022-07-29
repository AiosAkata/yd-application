<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <form name="searchReq" id="searchReq" method="get" action="/cms/user/list/0">
        <div class="searchArea">
            <label for="category" class="blind">검색 항목</label>
            <select name="category" id="category" title="검색항목">
                <option value="name">제목</option>
            </select>
            <label for="value" class="blind">검색어 입력</label>
            <input type="text" name="value" id="value" value="${searchReq.value}" placeholder="검색 키워드">
            <label for="searchSubmit" class="blind">검색 버튼</label>
            <input type="submit" id="searchSubmit" value="검색" class="searchButton">
            <p class="page">총 회원수 :<span class="count-1">${pagingInfo.totalItems}</span>건, 페이지 : <span class="count-2">${pagingInfo.curPage}/${pagingInfo.totalPage}</span></p>
        </div>
    </form>


        <table class="normalBoard list">
            <caption></caption>
            <colgroup>
                <col style="width:10%;">
                <col style="width:20%;">
                <col style="width:20%;">
                <col style="width:30%;">
            </colgroup>
            <thead>
            <tr>
                <th>순번</th>
                <th>제목</th>
                <th>url</th>
                <th>메모</th>
            </tr>
            </thead>
            <tbody>


            <c:forEach items="${pagingInfo.items}" var="banner" varStatus="status">
                <tr>
                    <td>
                        ${banner.id}
                    </td>
                    <td class="">
                        <a href="/cms/banner/read/${banner.id}" title="배너 제목">
                            ${banner.title}
                        </a>
                    </td>
                    <td class="">
                        <a href="/cms/banner/read/${banner.id}" title="배너 url">
                            ${banner.url}
                        </a>
                    </td>
                    <td class="">${banner.memo}</td>
                </tr>
            </c:forEach>



            </tbody>
        </table>
        <div class="pagingArea">
            <a href="/cms/banner/list/0${pathParam}">
                <img src="/images/common/rfc_bbs_btn_first.gif" alt="첫 페이지">
            </a>
            <a href="/cms/banner/list/${0 > pagingInfo.curPage - 10 ? 0 : pagingInfo.curPage - 10}${pathParam}">
                <img src="/images/common/rfc_bbs_btn_prev.gif" alt="이전 10개의 페이지">
            </a>
            <c:forEach begin="${pagingInfo.beginPage}" end="${pagingInfo.endPage}" varStatus="status">
                <a class="${status.index == pagingInfo.curPage ? "on" : ""}"
                   href="/cms/banner/list/${status.index}${pathParam}">${status.index + 1}</a>
            </c:forEach>
            <a href="/cms/banner/list/${pagingInfo.totalPage < pagingInfo.curPage + 10 ? pagingInfo.endPage : pagingInfo.curPage + 10}${pathParam}">
                <img src="/images/common/rfc_bbs_btn_next.gif" alt="다음 10개의 페이지">
            </a>
            <a href="/cms/banner/list/${pagingInfo.totalPage - 1}${pathParam}">
                <img src="/images/common/rfc_bbs_btn_last.gif" alt="마지막 페이지">
            </a>
        </div>



        <div class="buttonArea01">
            <button type="button" onclick="location.href='/cms/banner/create'" class="button01">배너 추가</button>
        </div>

</div>