<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <form name="memberForm" id="memberForm" method="post" action="/cms/banner/write" enctype="multipart/form-data">
        <table class="normalBoardWr">
            <caption></caption>
            <colgroup>
                <col style="width:20%;">
                <col style="width:80%;">
            </colgroup>
            <tbody>
            <tr>
                <th class="tLine"><span class="c_red">*</span> 제목</th>
                <td class="tLine">
                    <input type="text" name="title" required>
                </td>
            </tr>
            <tr>
                <th ><span class="c_red">*</span> 이미지 </th>
                <td >
                    <input type="file" name="file" id="file" value="" required>
                </td>
            </tr>
            <tr>
                <th > url </th>
                <td >
                    <input type="text" name="url" id="url" value="">
                </td>
            </tr>

            <tr>
                <th>메모</th>
                <td>
                    <input type="text" name="memo" id="memo" value="">
                </td>
            </tr>

            </tbody>
        </table>
        <div class="buttonArea02">
            <!-- memberNo(게시물번호) 값이 없을 경우 등록버튼 -->
            <button type="submit" class="button01">등록하기</button>


            <button type="button" onclick="goPrev();" class="button02">이전페이지</button>
        </div>
    </form>
    <script>
        function goPrev(){			//이전페이지
            history.back();
        }
    </script>
</div>