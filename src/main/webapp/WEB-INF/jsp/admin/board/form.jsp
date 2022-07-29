<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="<c:url value="/smarteditor2/css/ko_KR/smart_editor2.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/smarteditor2/css/ko_KR/smart_editor2_in.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/smarteditor2/css/ko_KR/smart_editor2_items.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/smarteditor2/css/ko_KR/smart_editor2_out.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/daumeditor/css/editor.css"/>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/daumeditor/js/editor_creator.js"/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/smarteditor2/js/lib/jindo2.all.js"/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/smarteditor2/js/lib/jindo_component.js"/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/smarteditor2/js/service/SE2M_Configuration.js"/>" charset="utf-8"></script>	<!-- 설정 파일 -->
<script type="text/javascript" src="<c:url value="/smarteditor2/js/service/SE2BasicCreator.js"/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/smarteditor2/js/smarteditor2.js"/>" charset="utf-8"></script>
<jsp:include page="/cms/header"/>
<style>
    .d-none{
        display: none;
    }
</style>
<div class="adminContents">
    <div id="board">
        <div class="board_view text-center">
            <form name="tx_editor_form" id="tx_editor_form" enctype="multipart/form-data" action="/cms/board/${type}/${kind}/${board.id}" method="POST" accept-charset="utf-8">
                <input type="hidden" name="rootId" value="${rootId}"/>
                <input type="hidden" name="writerId" value="${user.userId}"/>
                <input type="hidden" name="writerName" value="${user.name}"/>
                <input type="hidden" name="writerType" value=""/>
                <input type="hidden" name="adddata" value="" />
                <c:choose>
                    <c:when test="${board ne null}">
                        <input type="hidden" name="hasFile" value="${board.hasFile}"/>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="hasFile" value="false"/>
                    </c:otherwise>
                </c:choose>
                <table class="normalBoardWr">
                    <caption></caption>
                    <colgroup>
                        <col style="width:20%;" />
                        <col style="width:30%;" />
                        <col style="width:20%;" />
                        <col style="width:30%;" />
                    </colgroup>
                    <tbody>
                    <tr>
                        <th class="tLine">제목</th>
                        <td class="tLine" colspan="3"><input type="text" name="title" id="title" class="w_100" value="${board.title}" maxlength="100"/></td>
                    </tr>
                    <tr>
                        <th class="d-none">상단공지</th>
                        <td class="d-none">
                            <label><input type="radio" value="true" name="top" <c:if test="${board.isTop eq true}">checked</c:if>> 설정</label>
                            <label><input type="radio" value="false" name="top" <c:if test="${board.isTop eq false || board eq null}">checked</c:if>> 미설정</label>
                        </td>
                        <th>카테고리 변경</th>
                        <td colspan="3">
                            <select id="selectType" onchange="$('#type').val(this.value);">
                                <option value="notice" <c:if test="${type eq 'notice'}">selected</c:if>>공지사항</option>
                                <option value="calendar" <c:if test="${type eq 'calendar'}">selected</c:if>>특구일정</option>
                                <option value="recruit" <c:if test="${type eq 'recruit'}">selected</c:if>>인재채용</option>
                                <option value="data" <c:if test="${type eq 'data'}">selected</c:if>>자료실</option>
                                <option value="promo" <c:if test="${type eq 'promo'}">selected</c:if>>홍보자료</option>
                                <option value="news" <c:if test="${type eq 'news'}">selected</c:if>>보도자료</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td colspan="3">
                            <jsp:include page="../include/edit.jsp"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="buttonArea02">
                    <button type="button" onclick="location.href=document.referrer" class="button01">이전페이지</button>
                    <button type="button" class="button02" onclick="submitContents();">저장하기</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">

    var imagepath = "";
    var owncnt = 0;
    (function($){
        if(window.frameElement){
            // jindo.$("se2_sample").style.display = "none";
        }else{
            var oEditor = createSEditor2(jindo.$("ir1"), {
                bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                //bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
                //aAdditionalFontList : [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]],	// 추가 글꼴 목록
                fOnBeforeUnload : function(){
                    //예제 코드
                    //return "내용이 변경되었습니다.";
                }
            });

            oEditor.run({
                fnOnAppReady: function(){
                    //예제 코드
                    //oEditor.exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
                }
            });

            var imageCount = 0;
            var fileCount = 0;

            var tx_editor_form = $('#tx_editor_form');
            var tx_attach_list = $('#tx_attach_list');

            function pasteHTML(data) {
                var sHTML = "<div style='text-align:center' class='image-box-"+ data.imageurl + "'><img style='max-width:640px;' src='" + data.imageurl + "'><\/div>";
                tx_editor_form.append('<input type="hidden" name="images['+imageCount+'].path" value="' + data.imageurl + '">');
                tx_editor_form.append('<input type="hidden" name="images['+imageCount+'].filemime" value="' + data.filemime + '">');
                tx_editor_form.append('<input type="hidden" name="images['+imageCount+'].filename" value="' + data.filename + '">');
                tx_editor_form.append('<input type="hidden" name="images['+imageCount+'].filesize" value="' + data.filesize + '">');
                console.log(data.imageurl);

                var attachHTML = "<li class=\"type-image\" data-editor-id=\"" + imageCount + "\" data-attachurl=\"" + data.imageurl + "\">";
                    attachHTML += "<dl><dt class=\"tx-name\">" + data.filename +"</dt><dd class=\"tx-button\"><a class=\"tx-delete\">삭제</a><a class=\"tx-insert\">삽입</a></dd></dl></li>";

                tx_attach_list.append(attachHTML);

                oEditor.exec("PASTE_HTML", [sHTML]);

                if(owncnt>0){
                    imagepath += ",";
                }
                imagepath += "{ \"image\": \""+data.imageurl+"\" }";
                imageCount++;
                owncnt++;
            }

            window.pasteHTML = pasteHTML;

            function pasteFile(data) {
                tx_editor_form.append('<input type="hidden" name="files['+fileCount+'].path" value="' + data.attachurl + '">');
                tx_editor_form.append('<input type="hidden" name="files['+fileCount+'].filemime" value="' + data.filemime + '">');
                tx_editor_form.append('<input type="hidden" name="files['+fileCount+'].filename" value="' + data.filename + '">');
                tx_editor_form.append('<input type="hidden" name="files['+fileCount+'].filesize" value="' + data.filesize + '">');

                var attachHTML = "<li class=\"type-file\" data-target=\"file-" + data.filename + "\" data-editor-id=\"" + fileCount + "\" data-mime=\"" + data.filemime + "\">";
                attachHTML += "<dl><dt class=\"tx-name\">" + data.filename +"</dt><dd class=\"tx-button\"><a class=\"tx-delete\">삭제</a><a class=\"tx-insert\">삽입</a></dd></dl></li>";

                tx_attach_list.append(attachHTML);

                // oEditor.exec("PASTE_HTML", [sHTML]);
                fileCount++;
            }

            window.pasteFile = pasteFile;

            function deleteFile() {
                if( confirm("삭제하시면 본문에서도 삭제됩니다. 계속하시겠습니까?") ){

                    var self = $(this);
                    var fileId = self.data('id');
                    var parentList = self.closest('li');

                    // 파일 아이디가 있으면 삭제로직
                    if( fileId ){
                        $.post(
                            '/daumOpenEditor/delete/' + fileId,
                            function(data){
                            }
                        )
                    } else {
                        if( parentList.hasClass('type-image') ) {
                            // 선택한거 삭제!!!
                            $('#se2_iframe').contents().find('img').each(function (idx, el) {
                                if ($(el).attr('src') == parentList.data('attachurl')) {
                                    $(el).remove();
                                }
                            });
                            imageCount--;
                        }else {
                            $('#se2_iframe').contents().find("button[class^='file-']").each(function(idx, el){
                                if( $(el).attr('class') == parentList.data('target') ){
                                    $(el).remove();
                                }
                            });
                            fileCount--;
                        }
                    }

                    if( parentList.hasClass('type-image') ) {
                        $("[name^='images[" + parentList.data('editor-id') + "]']").each(function(input, key){
                            $( key ).remove();
                        });
                    } else {
                        $("[name^='files[" + parentList.data('editor-id') + "]']").each(function(input, key){
                            $( key ).remove();
                        });
                    }

                    delpath = JSON.parse("["+imagepath+"]");
                    imagepath = "";
                    for(num in delpath){
                        if(delpath[num].image == (parentList.data('attachurl'))){
                            owncnt--;
                        }else {
                            imagepath += "{ \"image\": \""+delpath[num].image+"\" },";
                        }
                    }
                    imagepath = imagepath.slice(0,-1);
                    console.log(imagepath);


                    self.closest('li').remove();
                    console.log($("#se2_iframe").contents().find("img[src='"+parentList.data('attachurl')+"']").parent().remove());
                }
            }

            function showHTML() {
                var sHTML = oEditor.getIR();
                alert(sHTML);
            }

            window.showHTML = showHTML;

            var submitFlag = false;
            function submitContents() {
                theForm = document.tx_editor_form;

                if (submitFlag == true)
                {
                    alert('게시물을 등록하고 있습니다. 잠시만 기다려 주세요.');
                    return false;
                }

                var type = $("#type").val();
                if(type === "programdata"){

                }

                if(owncnt>0){
                    theForm.adddata.value += "{\"files\": [" + imagepath + "]}";
                }else {
                }

                submitFlag = true;
                // 모든 항목이 비어있지 않기 때문에 여기까지 코드가 도달하고 다음의 submit() 함수 실행을 통해 폼을 넘기게(action) 됩니다.
                theForm.submit();

                oEditor.exec("UPDATE_CONTENTS_FIELD");	// 에디터의 내용이 textarea에 적용됩니다.

                // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
                jindo.$("ir1").form.submit();
            }

            window.submitContents = submitContents;

            function setDefaultFont() {
                var sDefaultFont = '궁서';
                var nFontSize = 24;
                oEditor.setDefaultFont(sDefaultFont, nFontSize);
            }
        }

        $('.tx-attach-list').on('mouseenter', 'li',function(){
            $(this).addClass('tx-hovered');
        });

        $('.tx-attach-list').on('mouseleave', 'li',function(){
            $(this).removeClass('tx-hovered');
        });

        $('.tx-attach-list').on('click', '> li',function(e){
            var self = $(this);
            self.addClass('tx-clicked').siblings().removeClass('tx-clicked');
            if( $(e.target).attr('class') != 'tx-delete' ){
                var previewSrc = "pn_preview.gif";

                if( self.data('mine') == 'application/vnd.ms-excel' ) {
                    previewSrc = 'p_xls.gif';
                } else if( self.data('mine') == 'application/haansoftpptx' ) {
                    previewSrc = 'pn_ppt.gif';
                } else if(self.data('mine') == 'application/pdf' ){
                    previewSrc = 'pn_pdf.gif';
                } else if(self.data('mine') == 'application/x-zip-compressed' ) {
                    previewSrc = 'pn_zip.gif';
                } else if(self.data('mine') == 'application/x-shockwave-flash' ){
                    previewSrc = 'pn_swf.gif';
                } else if(self.data('mine') == 'audio/mpegurl' ){
                    previewSrc = 'pn_music.gif';
                }

                if( self.data('attachurl') === undefined ){
                    $('.tx-attach-preview').find('img').attr('src', "/daumeditor/images/icon/editor/"+ previewSrc);
                } else {
                    $('.tx-attach-preview').find('img').attr('src', self.data('attachurl'));
                }

            }
        });

        $('.tx-attach-list').on('click', 'li .tx-delete' , deleteFile);


    })(jQuery);
</script>
<c:if test="${board ne null}">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <script>
        var jsonstr = '${board.addData}';
        var obj = JSON.parse(jsonstr);
        for(var i = 0 ; i < obj.files.length ; i++){
            if(i>0){
                imagepath += ",";
            }
            imagepath += "{ \"image\": \""+obj.files[i].image+"\" }";
            owncnt++;
        }
    </script>
</c:if>
<!--Example End-->
<script>
    function openChild()
    {
        window.name = "parent";
        openwin = window.open("/cms/program/list/popup/0", "프로그램 찾기", "width = 600, height = 400, resizeable = no, scrollbars = no");
    }

    function addProgramForm(title,id){
        $("#pro_title").val(title);
        $("#programId").val(id);
    }

</script>
<style>
    #smart_editor2 {
        width: 100% !important;
    }
    #smart_editor2 .se2_input_area{
        width: 100% !important;
    }
    body {
        font-family: inherit !important;
    }
</style>