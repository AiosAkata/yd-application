<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 합쳐지고 최소화된 최신 CSS -->

<jsp:include page="/cms/header"/>
<div class="adminContents">
    <form name="boardForm" id="boardForm" method="get" action="<c:url value='/mng/boardList.do'/>">
        <div class="searchArea">
            <select onchange="location.href='<c:url value="/cms/board/"/>'+this.value+'/list/0'" style="float: left">
                <option value="notice" <c:if test="${type eq 'notice'}">selected</c:if>>공지사항</option>
                <option value="calendar" <c:if test="${type eq 'calendar'}">selected</c:if>>특구일정</option>
                <option value="recruit" <c:if test="${type eq 'recruit'}">selected</c:if>>인재채용</option>
                <option value="data" <c:if test="${type eq 'data'}">selected</c:if>>자료실</option>
                <option value="promo" <c:if test="${type eq 'promo'}">selected</c:if>>홍보자료</option>
                <option value="news" <c:if test="${type eq 'news'}">selected</c:if>>보도자료</option>
            </select>
            <select name="category" id="category" title="검색항목">
                <option value="title" <c:if test="${SearchReq.category eq 'title'}">selected</c:if>>제목</option>
                <option value="writer" <c:if test="${SearchReq.category eq 'writer'}">selected</c:if>>작성자</option>
            </select>
            <input type="text" name="value" id="value" value="${SearchReq.value}" />
            <button type="submit" class="searchButton">검색</button>
        </div>
    </form>
    <table class="normalBoard list">
        <caption></caption>
        <colgroup>
            <col style="width:10%;" />
            <col style="width:40%;" />
            <col style="width:20%;" />
            <col style="width:20%;" />
            <col style="width:10%;" />
        </colgroup>
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${fn:length(pagingInfo.items) > 0}">
                <c:forEach items="${pagingInfo.items}" var="board" varStatus="status">
                    <tr>
                        <td>${board.id}</td>
                        <td><a href="/cms/board/${type}/read/${board.id}">${board.title}</a></td>
                        <td>${board.writerId}</td>
                        <td><fmt:formatDate value="${board.createdDate}" pattern="yyyy.MM.dd HH:mm"/></td>
                        <td>${board.hit}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="5">게시물이 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <div class="buttonArea01">
        <button type="button" onclick="location.href='<c:url value="/cms/board/${type}/create"/>'" class="button01">글쓰기</button>
    </div>
    <div class="pagingArea">
        <a href="/cms/board/${type}/list/0${pathParam}">
            <img src="/images/common/rfc_bbs_btn_first.gif" alt="첫 페이지">
        </a>
        <a href="/cms/board/${type}/list/${0 > pagingInfo.curPage - 10 ? 0 : pagingInfo.curPage - 10}${pathParam}">
            <img src="/images/common/rfc_bbs_btn_prev.gif" alt="이전 10개의 페이지">
        </a>
        <c:forEach begin="${pagingInfo.beginPage}" end="${pagingInfo.endPage}" varStatus="status">
            <a class="${status.index == pagingInfo.curPage ? "on" : ""}"
               href="/cms/board/${type}/list/${status.index}${pathParam}">${status.index + 1}</a>
        </c:forEach>
        <a href="/cms/board/${type}/list/${pagingInfo.totalPage < pagingInfo.curPage + 10 ? pagingInfo.endPage : pagingInfo.curPage + 10}${pathParam}">
            <img src="/images/common/rfc_bbs_btn_next.gif" alt="다음 10개의 페이지">
        </a>
        <a href="/cms/board/${type}/list/${pagingInfo.totalPage - 1}${pathParam}">
            <img src="/images/common/rfc_bbs_btn_last.gif" alt="마지막 페이지">
        </a>
    </div>
</div>