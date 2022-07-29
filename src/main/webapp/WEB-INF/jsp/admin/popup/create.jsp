<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/cms/header"/>
<div class="adminContents">
    <form name="memberForm" id="memberForm" method="post" action="/cms/popup/write" enctype="multipart/form-data">
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
                    <input type="text" name="title" class="w_95" required>
                </td>
            </tr>
            <tr>
                <th ><span class="c_red">*</span> 이미지 </th>
                <td >
                    <p style="color: red">팝업 사이즈는 3(가로):4(세로) 비율을 권장합니다.</p>
                    <input type="file" name="file" id="file" class="w_95" value="" required>
                </td>
            </tr>
            <tr>
                <th ><span class="c_red">*</span> 시작시간 </th>
                <td >
                    <input type="date" name="startDate" max="9999-12-31" id="startDate" value="" required>
                    <input type="time" name="startTime" id="startTime" value="00:00" required>
                </td>
            </tr>
            <tr>
                <th ><span class="c_red">*</span> 종료시간 </th>
                <td >
                    <input type="date" name="endDate" max="9999-12-31" id="endDate" value="" required>
                    <input type="time" name="endTime" id="endTime" value="23:59" required>
                </td>
            </tr>
            <tr>
                <th >ON/OFF</th>
                <td>
                    <input type="checkbox" id="sw" name="sw" class="input__on-off">
                    <label for="sw" class="label__on-off">
                        <span class="marble"></span>
                    </label>
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