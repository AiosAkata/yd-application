<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<jsp:include page="/cms/header"/>
<style>
    .page{
        text-align: left;
    }
    .page .cnt {
        border-right: 1px solid #cccccc;
        padding-right: 10px;
        margin-right: 10px;
    }
    .page .cnt .realnumber{
        color: blue;
        font-weight: bold;
    }
    .page .cnt:last-child {
        border-right: none;
        padding-right: 0;
        margin-right: 0;
    }
</style>
<div class="adminContents">
    <form name="searchReq" id="searchReq" method="get" action="0">
        <div class="searchArea">
            <label for="category" class="blind">검색 항목</label>
            <input type="date" value="${dateStr}" onchange="location.href='/cms/reserve/list/'+this.value+'/13/0'">
            <select onchange="location.href='/cms/reserve/list/${dateStr}/'+this.value+'/0'"
                    id="category"
                    title="검색항목">
                <option value="13" <c:if test="${timeStr eq '13'}">selected</c:if>>오후 1시</option>
                <option value="14" <c:if test="${timeStr eq '14'}">selected</c:if>>오후 2시</option>
                <option value="15" <c:if test="${timeStr eq '15'}">selected</c:if>>오후 3시</option>
                <option value="16" <c:if test="${timeStr eq '16'}">selected</c:if>>오후 4시</option>
                <option value="17" <c:if test="${timeStr eq '17'}">selected</c:if>>오후 5시</option>
                <option value="18" <c:if test="${timeStr eq '18'}">selected</c:if>>오후 6시</option>
                <option value="19" <c:if test="${timeStr eq '19'}">selected</c:if>>오후 7시</option>
                <option value="20" <c:if test="${timeStr eq '20'}">selected</c:if>>오후 8시</option>
                <option value="21" <c:if test="${timeStr eq '21'}">selected</c:if>>오후 9시</option>
            </select>
            <label for="key" class="blind">검색어 입력</label>
            <input type="text" name="key" id="key" value="${key}" placeholder="검색 키워드(이름,전화번호,접수번호 통합검색)">
            <label for="searchSubmit" class="blind">검색 버튼</label>
            <input type="submit" id="searchSubmit" value="검색" class="searchButton">
            <input type="button" id="searchButtonRight" onclick="location.href='0'" value="초기화" class="searchButtonRight">
            <p class="page">
                <span class="cnt">축제장 입장 : <b class="realnumber"> ${cnt.user} </b>/ ${cnt.total} </span>
                <c:if test="${cnt.manggyeong ne null}">
                    <span class="cnt"> 버스킹공연(진주성) : <b class="realnumber">${cnt.castle}</b> / 50 </span>
                    <span class="cnt"> 버스킹공연(망경동남강둔치) : <b class="realnumber">${cnt.manggyeong}</b> / 50 </span>
                </c:if> </p>
        </div>
    </form>


        <table class="normalBoard list">
            <caption></caption>
            <colgroup>
                <col style="width:10%;">
                <col style="width:10%;">
                <col style="width:20%;">
                <col style="width:10%;">
                <col style="width:10%;">
                <col style="width:40%;">
            </colgroup>
            <thead>
            <tr>
                <th>이름</th>
                <th>성별</th>
                <th>백신접종일자</th>
                <th>전화번호</th>
                <th>접수번호</th>
                <th>입장예약</th>
            </tr>
            </thead>
            <tbody>


            <c:forEach items="${pagingInfo.items}" var="yd" varStatus="status">
                <tr>
                    <td>
                        ${yd.name}
                    </td>
                    <td>
                        ${yd.gender}
                    </td>
                    <td>
                        ${yd.vac}
                    </td>
                    <td class="">
                            ${yd.phone}
                    </td>
                    <td class="">
                        ${yd.appNumber}
                    </td>
                    <td class="">
                        ${yd.enter}
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

</div>

<script>


    function updateOnOff(id, target){
        var chkbox = $(target).parent().find("input[type=checkbox]:checked");
        var chkval = chkbox.val();
        var sw = (chkval === 'chk');

        $.ajax({
            url: '/cms/crawl/onoff',
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
</script>