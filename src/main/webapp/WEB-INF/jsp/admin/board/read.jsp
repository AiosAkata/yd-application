<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <table class="normalBoardWr">
        <caption>${board.title} 게시물의 내용입니다.</caption>
        <colgroup>
            <col style="width: 20%;" />
            <col style="width: 30%;" />
            <col style="width: 20%;" />
            <col style="width: 30%;" />
        </colgroup>
        <tbody>
        <tr>
            <th class="tLine">제목</th>
            <td class="tLine">${board.title}</td>
            <th class="tLine">대학</th>
            <td class="tLine">${board.writerType}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${board.writer}</td>
            <th>작성일</th>
            <td>${board.createdAt}</td>
        </tr>
        <tr>
            <th>상단공지 표시여부</th>
            <td colspan="3"><c:choose><c:when test="${board.isTop eq true}">표시</c:when><c:otherwise>비표시</c:otherwise></c:choose></td>
        </tr>
        <tr>
            <th>첨부파일</th>
            <td colspan="3">
                <ul>
                    <c:forEach items="${board.files}" var="fileData">
                        <li>
                            <a href="<c:url value="${fileData.path}"/>" title="${fileData.filename} 파일 다운로드" download="${fileData.filename}">
                                ${fileData.filename}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${board.files.size() eq 0}">
                        첨부파일이 없습니다.
                    </c:if>
                </ul>
            </td>
        </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    ${board.content}
                </td>
            </tr>
        </tbody>
    </table>
    <div class="buttonArea01">
        <button type="button" onclick="location.href='/cms/board/${type}/update/${board.id}'" class="button01">수정</button>
        <button type="button" onclick="goDelete();" class="button01">삭제</button>
        <button type="button" onclick="goList();" class="button02">이전페이지</button>
    </div>
</div>
<script>
    function goDelete(){
        if(confirm("정말로 삭제하시겠습니까? 되돌릴 수 없습니다.")){
            location.href="/cms/board/${type}/delete/${board.id}";
        }
    }
    function goList(){
        history.back(-1);
    }
</script>