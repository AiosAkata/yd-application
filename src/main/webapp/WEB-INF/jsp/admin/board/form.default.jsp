<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>$(document).ready(function(){
    $("#board_default").css("width","100%;")
})

</script>
<div id="container"  style="width:1800px!important">
    <table class="" style="margin-top:115px;float:right;display:inline-block;width:1500px!important">
        <colgroup>
            <col width="15%">
            <col width="*">
        </colgroup>
        <thead>
        <tr>
            <th class="require">제목</th>
            <td style="width:500px">
                <div class="form-inline">
                    <input id="title" name="title" style="width: 90%; box-sizing: border-box;float: left" class="form-control"
                           value="${board.title}" required>
                    <!--<label class="checkbox-inline" for="isScured"><input type="checkbox" id="isScured" name="isScured" title="비밀글작성" value="true" checked="checked">비밀글</label>-->
                </div>
            </td>
        </tr>
        </thead>
        <tbody>
        <tr>
        <th>내용</th>
        <td>
            <jsp:include page="../include/edit.jsp"/>
        </td>
        </tr>

        </tbody>
    </table>
</div>
