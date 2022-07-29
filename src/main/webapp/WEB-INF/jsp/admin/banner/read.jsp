<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <form name="memberForm" id="memberForm" method="post" action="/cms/user/write">
        <table class="normalBoardWr">
            <caption></caption>
            <colgroup>
                <col style="width:20%;">
                <col style="width:80%;">
            </colgroup>
            <tbody>
            <tr>
                <th class="tLine">회원권한</th>
                <td class="tLine">
                </td>
            </tr>
            <tr>
                <th > 제목 </th>
                <td >
                    ${banner.title}
                </td>
            </tr>

            <tr>
                <th>이미지</th>
                <td>
                    <img src="${banner.image}" title="${banner.title}" onerror="this.src='/images/common/no_img3.png'">
                </td>
            </tr>
            <tr>
                <th>url</th>
                <td>${banner.url}</td>
            </tr>

            <tr>
                <th>메모</th>
                <td>
                    ${banner.memo}
                </td>
            </tr>

            </tbody>
        </table>
    </form>
    <div class="buttonArea02">
        <!-- memberNo(게시물번호) 값이 없을 경우 등록버튼 -->
        <button type="button" onclick="location.href='/cms/banner/update/${banner.id}';" class="button01">수정하기</button>
        <button type="button" onclick="goDelete();" class="button01">삭제</button>
        <button type="button" onclick="goPrev();" class="button02">이전페이지</button>
    </div>
    <script>
        function goDelete(){
            if(confirm("정말로 삭제하시겠습니까?")){
                location.href='/cms/banner/delete/${banner.id}'
            }
        }

        function goPrev(){			//이전페이지
            history.back();
        }

    </script>
</div>
<style>

    img{
        max-width: 50%;
        max-height: 300px;
    }
</style>