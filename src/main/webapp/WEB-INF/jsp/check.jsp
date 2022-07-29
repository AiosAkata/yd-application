<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/head"/>
<jsp:include page="/header"/>
<style>
    .uploaded_file{
        text-decoration: underline;
    }
</style>

<section class="yd-reservation clearfix">
    <img src="<c:url value="/images/common/ico-prev.png"/>" class="prev-page">
    <img src="<c:url value="/images/common/yd-logo.png"/>" class="yd-logo yd-logo-form">
    <div class="ydr-tit">진주남강유등축제 등(燈)공모대전 참가 신청서</div>
    <div class="ydr-form-list" id="origin">
        <div class="ydr-form-item">
            <h6 class="me">신청 상태</h6>
            <p class="ydr-form-tit">상태</p>
            ${app.status}
        </div>
        <div class="ydr-form-item">
            <h6 class="me">신청자(본인)</h6>
            <p class="ydr-form-tit">이름</p>
            ${app.name}
        </div>
        <div class="ydr-form-item">
            <p class="ydr-form-tit">전화번호</p>
            ${app.phone}
        </div>
        <div class="ydr-form-item">
            <p class="ydr-form-tit">이메일</p>
            ${app.email}
        </div>

        <div class="ydr-form-item">
            <h6 class="others">신청서 파일</h6>
            <p class="ydr-form-tit">1. 출품서 및 출품원서</p>
            <a class="uploaded_file" href="https://d6wpkpxs3gsww.cloudfront.net${app.file1}" target="_blank" download="">${app.filename1}</a>
        </div>

        <div class="ydr-form-item">
            <p class="ydr-form-tit">2. 디자인 제안서</p>
            <a class="uploaded_file" href="https://d6wpkpxs3gsww.cloudfront.net${app.file2}" target="_blank" download="">${app.filename2}</a>
        </div>
    </div>

    <fmt:parseDate value="${app.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="now"
                   type="both"/>
    <div id="next" class="ydr-form-item-last">
        <p>상기 본인은 위와 같이 「진주남강유등축제 등(燈)공모대전」 참여를 신청합니다.</p>
        <p><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일"/></p>
        <p>신청자 <text id="sign">${app.name}</text></p>
    </div>
    <button class="ydr-btn a-check form-btn" type="button" onclick="deleteReserve()" >신청 취소</button>
    <button class="ydr-btn a-alone form-btn" type="button" onclick="goUpdate()">수정하기</button>
</section>

<form action="<c:url value="/delete"/>" method="post" name="deleteForm">
    <input type="hidden" name="dupInfo" value="${app.dupInfo}">
</form>

<script>
    function goUpdate(){
        location.href='/update'
    }

    function deleteReserve(){
        if(confirm("정말로 신청을 취소하시겠습니까?")){
            document.deleteForm.submit();
        }
    }
</script>
<jsp:include page="/footer"/>
