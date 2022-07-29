<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/head"/>
<jsp:include page="/header"/>

<section class="yd-reservation clearfix">
    <img src="/images/common/ico-prev.png" class="prev-page">
    <img src="/images/common/yd-logo.png" class="yd-logo yd-logo-form">
    <div class="ydr-ok">
        <div class="ydr-tit">예약확인</div>
        <c:choose>
            <c:when test="${reserve ne null}">
                <div class="ydr-ok-item">
                    <p class="ydr-ok-tit"><span>예약입장일자</span> ${reserve.date}</p>
                    <p class="ydr-ok-tit"><span>예약입장시간</span> ${reserve.time}</p>
                    <p class="ydr-ok-tit ok-together"><span>예약참여행사</span> ${fn:replace(reserve.enter, ",", "/")}</p>
                </div>

                <div class="ydr-btn a-check form-btn" onclick="document.updateTo.submit();">수정하기 / 예약취소</div>
                <form name="updateTo" action="/update" method="post">
                    <input type="hidden" value="${reserve.appNumber}" name="number">
                    <input type="hidden" value="${reserve.phone}" name="phone">
                </form>
            </c:when>
            <c:otherwise>
                <div class="ydr-ok-item">
                    <p class="ydr-ok-tit">입력하신 정보로 조회된 예약이 없습니다.</p>
                    <p class="ydr-ok-tit">다시 한번 확인하시고 시도해 주세요.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<jsp:include page="/footer"/>