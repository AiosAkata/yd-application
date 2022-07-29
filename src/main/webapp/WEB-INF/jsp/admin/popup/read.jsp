<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <form name="memberForm" id="memberForm" method="post" action="/cms/user/write">
        <table class="normalBoardWr">
            <caption></caption>
            <colgroup>
                <col style="width:20%;">
                <col style="width:80%;">
            </colgroup>
            <tbody>
            <tr>
                <th class="tLine"> 제목 </th>
                <td class="tLine">
                    ${popup.title}
                </td>
            </tr>
            <tr>
                <th > 표시여부 </th>
                <td >
                    <c:if test="${popup.isOn}">Y</c:if>
                    <c:if test="${!popup.isOn}">N</c:if>
                </td>
            </tr>
            <fmt:parseDate value="${popup.startAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime1" type="both"/>
            <fmt:parseDate value="${popup.endAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime2" type="both"/>
            <tr>
                <th > 팝업 시작시간 </th>
                <td >
                    <fmt:formatDate value="${parsedDateTime1}" pattern="yyyy.MM.dd HH:mm"/>
                </td>
            </tr>

            <tr>
                <th > 팝업 종료시간 </th>
                <td >
                    <fmt:formatDate value="${parsedDateTime2}" pattern="yyyy.MM.dd HH:mm"/>
                </td>
            </tr>

            <tr>
                <th>이미지</th>
                <td>
                    <img src="${popup.image}" title="${popup.title}" onerror="this.src='/images/common/no_img3.png'">
                </td>
            </tr>

            </tbody>
        </table>
    </form>
    <div class="buttonArea02">
        <!-- memberNo(게시물번호) 값이 없을 경우 등록버튼 -->
        <button type="button" onclick="goDelete();" class="button01-D">삭제</button>
        <button type="button" onclick="goPrev();" class="button02">이전페이지</button>
    </div>
    <script>
        function goDelete(){
            if(confirm("정말로 삭제하시겠습니까?")){
                location.href='/cms/popup/delete/${popup.id}'
            }
        }

        function goPrev(){			//이전페이지
            history.back();
        }

    </script>
</div>
<style>
    img{
        max-width: 50%;
        max-height: 300px;
    }
</style>