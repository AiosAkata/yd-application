<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<script>
    alert('휴대폰본인인증이 정상적으로 처리되었습니다.');
    opener.location.href='<c:url value="${url}"/>';
    window.close();
</script>
</body>
</html>