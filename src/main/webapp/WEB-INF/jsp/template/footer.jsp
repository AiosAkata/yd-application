<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<script>
    $(".prev-page").on("click",function (){
        history.back(-1);
    })
</script>