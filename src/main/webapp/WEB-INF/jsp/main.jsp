<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/head"/>
<style>

    .pcr-alert{
        font-size: 14px;
        color: red;
    }
</style>
<jsp:include page="/header"/>
<section class="yd-reservation">
    <img src="<c:url value="/images/common/yd-logo.png"/>" class="yd-logo">
    <div class="ydr-info">
        진주남강유등축제 등(燈)공모대전 참가신청 시스템입니다.<br>
        신청기간은 8월 4일 10시부터 8월 8일 18시까지입니다.<br><br>
        <img src="<c:url value="/images/main/yd_main.jpg"/>">
    </div>
    <div class="ydr-btns">
        <a href="https://d6wpkpxs3gsww.cloudfront.net/files/2022+%EC%A7%84%EC%A3%BC%EB%82%A8%EA%B0%95%EC%9C%A0%EB%93%B1%EC%B6%95%EC%A0%9C+%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD+%EB%93%B1%EA%B3%B5%EB%AA%A8%EB%8C%80%EC%A0%84+%EC%B6%9C%ED%92%88%EC%84%9C+%EB%B0%8F+%EC%B6%9C%ED%92%88%EC%9B%90%EC%84%9C.hwp"
           target="_blank" download>
            <div class="ydr-btn file-download">
                <img src="<c:url value="/images/common/icon-down_2.png"/>">
                출품서 및 출품원서 서식 다운로드
            </div>
        </a>
        <a href="https://d6wpkpxs3gsww.cloudfront.net/files/2022+%EC%A7%84%EC%A3%BC%EB%82%A8%EA%B0%95%EC%9C%A0%EB%93%B1%EC%B6%95%EC%A0%9C+%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD%EB%93%B1%EA%B3%B5%EB%AA%A8%EB%8C%80%EC%A0%84+%EB%94%94%EC%9E%90%EC%9D%B8+%EC%A0%9C%EC%95%88%EC%84%9C.hwp"
           target="_blank" download>
            <div class="ydr-btn file-download">
                <img src="<c:url value="/images/common/icon-down_2.png"/>">
                디자인 제안서 서식 다운로드
            </div>
        </a>
        <div class="ydr-btn a-alone" onclick="fnPopup()">신청하기</div>
        <div class="ydr-btn a-check" onclick="chkPopup()">신청확인/수정/취소</div>
    </div>
</section>

<form name="form_submit" method="post" enctype="application/x-www-form-urlencoded" accept-charset="UTF-8">
    <input type="hidden" name="m" value="checkplusSerivce">
    <input type="hidden" name="EncodeData" value="${ sEncData }">
</form>


<form name="form_chk" method="post" enctype="application/x-www-form-urlencoded" accept-charset="UTF-8">
    <input type="hidden" name="m" value="checkplusSerivce">
    <input type="hidden" name="EncodeData" value="${ sCheckData }">
</form>
<script>
    function fnPopup() {
        if(confirm("본인 인증 후 신청이 가능합니다. 본인인증을 하시겠습니까?")){
            window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_submit.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_submit.target = "popupChk";
            document.form_submit.submit();
        }
    }
    function chkPopup() {
        if(confirm("본인 인증 후 신청 확인이 가능합니다. 본인인증을 하시겠습니까?")){
            window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.target = "popupChk";
            document.form_chk.submit();
        }
    }
</script>

<jsp:include page="/footer"/>