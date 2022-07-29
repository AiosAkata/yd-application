<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>진주남강유등축제 등(燈)공모대전 :: 관리자 페이지</title>
    <!-- <script src="/js/jquery.min.js"></script> -->
    <script src="/js/jquery-3.4.0.min.js"></script>
    <script src="<c:url value="/js/jquery-ui.min.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/css/jquery-ui.min.css"/>">
    <link href="/css/admin.css" rel="stylesheet">
    <link href="/css/hs.css" rel="stylesheet">
</head>

<div class="adminLeftMenu">
    <div class="left_top">
        <div class="logoArea" style="cursor: pointer" onclick="location.href='/'">
            <img class="smart-logo" src="/images/common/yd-logo.png" alt="로고"/>
        </div>
        <div class="userInfoArea">
            <strong>${user.name}</strong>님 환영합니다!&nbsp;
            <p class="logoutButton"><a href="/doLogout" title="로그아웃">LOGOUT</a></p>
        </div>
    </div>
    <c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
    <ul>
        <li <c:if test="${fn:contains(path, '/cms/reserve')}">class="selectMenu"</c:if> ><a href="/cms/reserve">신청자 관리</a></li>
        <li <c:if test="${fn:contains(path, '/cms/cnt')}">class="selectMenu"</c:if> ><a href="/cms/cnt">방역 인원수 관리</a></li>
        <li <c:if test="${fn:contains(path, '/cms/analysis')}">class="selectMenu"</c:if> ><a href="/cms/analysis">예약자 통계</a></li>
    </ul>
</div>
<div class="admin_tit">
    <p>
        <svg xmlns='' class='ionicon' style="fill:#fff; width:30px; height: 30px;" viewBox='0 0 512 512'>
            <title>Folder Open</title>
            <path d='M408 96H252.11a23.89 23.89 0 01-13.31-4L211 73.41A55.77 55.77 0 00179.89 64H104a56.06 56.06 0 00-56 56v24h416c0-30.88-25.12-48-56-48zM423.75 448H88.25a56 56 0 01-55.93-55.15L16.18 228.11v-.28A48 48 0 0164 176h384.1a48 48 0 0147.8 51.83v.28l-16.22 164.74A56 56 0 01423.75 448zm56.15-221.45z'/>
        </svg>
        진주남강유등축제 등(燈)공모대전 관리자 페이지
    </p>
</div>
<p class="home_btn">
    <a href="/"> HOME</a>
</p>