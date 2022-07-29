<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<jsp:include page="/cms/header"/>
<style>
    .right-line{
        border-right: 1px solid #efefef;
    }
    .border-start-0{
        border-left: 0 !important;
    }
</style>
<div class="adminContents">
    <div class="buttonArea01 ta-left">
    <p>문제가 발생할 경우, 특정 페이지를 제외하고 크롤링을 할 수 있습니다.</p>
    </div>
    <form action="/cms/cnt/save" method="post">
    <table class="normalBoard list">
        <colgroup>
            <col style="width: 30%">
            <col style="width: 20%">
            <col style="width: 30%">
            <col style="width: 20%">
        </colgroup>
        <thead>
        <tr>
            <th>시각</th>
            <th class="right-line">인원수</th>
            <th class="border-start-0">시각</th>
            <th>인원수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="time" varStatus="status">
            <c:if test="${status.index % 2 eq 0}">
                <tr>
            </c:if>
                    <td>${time.time}</td>
                    <td class="right-line">
                        <input type="number" name="${time.time}" value="${time.ydCnt}">
                    </td>
            <c:if test="${status.index % 2 eq 1}">
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table><div class="buttonArea01">
        <button type="submit" class="button02">저장</button>
    </div>
    </form>
</div>

<script>


    function updateOnOff(type, target){
        var chkbox = $(target).parent().find("input[type=checkbox]:checked");
        var chkval = chkbox.val();
        var sw = (chkval === 'chk');

        $.ajax({
            url: '/cms/crawl/conf/onoff',
            type: 'POST',
            data: {
                'type': type,
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