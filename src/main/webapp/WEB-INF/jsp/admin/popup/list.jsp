<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <form name="searchReq" id="searchReq" method="get" action="/cms/popup/list/0">
        <div class="searchArea">
            <label for="category" class="blind">검색 항목</label>
            <select name="category" id="category" title="검색항목">
                <option value="name">제목</option>
            </select>
            <label for="value" class="blind">검색어 입력</label>
            <input type="text" name="value" id="value" value="${searchReq.value}" placeholder="검색 키워드">
            <label for="searchSubmit" class="blind">검색 버튼</label>
            <input type="submit" id="searchSubmit" value="검색" class="searchButton">
            <input type="button" onclick="location.href='0'" value="초기화" class="resetButton">
        </div>
    </form>


        <table class="normalBoard list">
            <caption></caption>
            <colgroup>
                <col style="width:30%;">
                <col style="width:20%;">
                <col style="width:20%;">
                <col style="width:20%;">
                <col style="width:10%;">
            </colgroup>
            <thead>
            <tr>
                <th>제목</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>ON/OFF</th>
                <th>삭제</th>
            </tr>
            </thead>
            <tbody>


            <c:forEach items="${pagingInfo.items}" var="popup" varStatus="status">
                <fmt:parseDate value="${popup.startAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime1" type="both"/>
                <fmt:parseDate value="${popup.endAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime2" type="both"/>
                <tr>
                    <td class="">
                        <a href="/cms/popup/read/${popup.id}" title="배너 제목">
                            ${popup.title}
                        </a>
                    </td>
                    <td class=""><fmt:formatDate value="${parsedDateTime1}" pattern="yyyy.MM.dd HH:mm"/></td>
                    <td class=""><fmt:formatDate value="${parsedDateTime2}" pattern="yyyy.MM.dd HH:mm"/></td>
                    <td class="">
                        <input type="checkbox" id="switch${popup.id}" name="switch" class="input__on-off" value="chk" <c:if test="${popup.isOn}">checked</c:if> >
                        <label for="switch${popup.id}" class="label__on-off" onclick="updateOnOff(${popup.id},this)">
                            <span class="marble"></span>
                        </label>
                    </td>
                    <td class="">
                        <button type="button" class="button05-D" onclick="goDelete(${popup.id})">삭제</button>
                    </td>
                </tr>
            </c:forEach>



            </tbody>
        </table>
        <div class="pagingArea">
            <a href="0${pathParam}">
                <img src="/images/common/rfc_bbs_btn_first.gif" alt="첫 페이지">
            </a>
            <a href="${0 > pagingInfo.curPage - 10 ? 0 : pagingInfo.curPage - 10}${pathParam}">
                <img src="/images/common/rfc_bbs_btn_prev.gif" alt="이전 10개의 페이지">
            </a>
            <c:forEach begin="${pagingInfo.beginPage}" end="${pagingInfo.endPage}" varStatus="status">
                <a class="${status.index == pagingInfo.curPage ? "on" : ""}"
                   href="${status.index}${pathParam}">${status.index + 1}</a>
            </c:forEach>
            <a href="${pagingInfo.totalPage < pagingInfo.curPage + 10 ? pagingInfo.endPage : pagingInfo.curPage + 10}${pathParam}">
                <img src="/images/common/rfc_bbs_btn_next.gif" alt="다음 10개의 페이지">
            </a>
            <a href="${pagingInfo.totalPage - 1}${pathParam}">
                <img src="/images/common/rfc_bbs_btn_last.gif" alt="마지막 페이지">
            </a>
        </div>



        <div class="buttonArea01">
            <button type="button" onclick="location.href='/cms/popup/create'" class="button01">팝업 추가</button>
        </div>

    <script>
        function updateOnOff(id, target){
            var chkbox = $(target).parent().find("input[type=checkbox]:checked");
            var chkval = chkbox.val();
            var sw = (chkval === 'chk');

            $.ajax({
                url: '/cms/popup/onoff',
                type: 'POST',
                data: {
                    'id': id,
                    'sw': sw
                },
                success: function(data){ // 정상 요청, 응답 시 처리 작업
                    chkbox.attr("checked",data);
                },
                error : function(xhr, status, error) {
                    alert("서버와의 통신에 실패했습니다.")
                    window.location.reload()
                }
            })
        }

        function goDelete(id){
            if(confirm("정말로 삭제하시겠습니까?")){
                location.href='/cms/popup/delete/'+id
            }
        }
    </script>

</div>