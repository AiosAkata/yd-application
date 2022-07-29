<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/head"/>
<jsp:include page="/header"/>
<form id="reserveForm" name="reserveForm" onsubmit="return chkForm()" method="post" action="<c:url value="/modify"/>">
    <input type="hidden" name="sDupInfo" value="${app.dupInfo}">
    <input type="hidden" name="gender" value="${app.gender}">
    <input type="hidden" name="birth" value="${app.birth}">
    <section class="yd-reservation clearfix">
        <img src="<c:url value="/images/common/ico-prev.png"/>" class="prev-page">
        <img src="<c:url value="/images/common/yd-logo.png"/>" class="yd-logo yd-logo-form">
        <div class="ydr-tit">진주남강유등축제 등(燈)공모대전 신청서 수정</div>
        <div class="ydr-form-list" id="origin">
            <div class="ydr-form-item">
                <h6 class="me">신청자 정보</h6>
                <p class="ydr-form-tit">이름을 입력해주세요.<span class="tomato">*필수</span></p>
                <input type="text" placeholder="이름을 입력해주세요." id="name" name="name" value="${app.name}" required>
            </div>
            <div class="ydr-form-item">
                <p class="ydr-form-tit">전화번호를 입력해주세요.<span class="tomato">*필수</span></p>
                <input type="text" placeholder="-없이 입력해주세요. 예)01023456789" value="${app.phone}" name="phone" class="onlyNumber" inputmode="numeric" required>
            </div>
            <div class="ydr-form-item">
                <p class="ydr-form-tit">이메일을 입력해주세요.<span class="tomato">*필수</span></p>
                <input type="email" placeholder="연락 가능한 이메일을 입력해 주세요." value="${app.email}" name="email" class="" inputmode="email" required>
            </div>
            <div class="ydr-form-item">
                <h6 class="others">신청서 파일 제출</h6>
                <p class="ydr-form-tit">1. 출품서 및 출품원서<span class="tomato">*필수</span></p>
                <input type="hidden" name="file1" class="hidden1" value="${app.file1}">
                <input type="hidden" name="file1name" class="hidden2" value="${app.filename1}">
                <div>
                    <a class="fileUploaded" href="https://d6wpkpxs3gsww.cloudfront.net${app.file1}" target="_blank" download="">${app.filename1}</a>
                    <button type="button" class="post-button" onclick="resetButton(this)">다시제출</button>
                </div>
            </div>
            <div class="ydr-form-item">
                <p class="ydr-form-tit">2. 디자인 제안서<span class="tomato">*필수</span></p>
                <input type="hidden" name="file2" class="hidden1" value="${app.file2}">
                <input type="hidden" name="file2name" class="hidden2" value="${app.filename2}">
                <div>
                    <a class="fileUploaded" href="https://d6wpkpxs3gsww.cloudfront.net${app.file2}" target="_blank" download="">${app.filename2}</a>
                    <button type="button" class="post-button" onclick="resetButton(this)">다시제출</button>
                </div>
            </div>
            <div class="ydr-form-item">
                <h6 class="others">개인정보 수집 및 이용에 대한 동의</h6>
                <div class="apply-box">

                    <div class="article">
                        <h3 class="article__title">개인정보처리방침</h3>
                        <p class="article__text">
                            “진주남강유등축제”는 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다. “진주남강유등축제”는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항 (또는 개별공지)을 통하여 공지할 것입니다. 본 방침은 2018년 08월 01일부터 시행됩니다.
                        </p>
                    </div>
                    <div class="article">
                        <h3 class="article__title">수집하는 개인정보 항목</h3>
                        <p class="article__text">
                            “진주남강유등축제”는 진행하는 프로그램 등의 진행을 위해 아래와 같은 개인정보를 수집하고 있습니다.<br>
                        </p>
                        <ul class="list_style_dot">
                            <li>수집항목 : 이름, 연락처(휴대폰 번호 및 일반 전화번호), E-mail 주소, 접속 로그인 , 접속 IP 정보</li>
                            <li>개인정보 수집방법 : 홈페이지 (프로그램신청)</li>
                        </ul>
                    </div>
                    <div class="article">
                        <h3 class="article__title">개인정보의 수집 및 이용목적</h3>
                        <p class="article__text">
                            “진주남강유등축제”는 수집한 개인정보를 다음의 목적을 위해 활용합니다.<br>
                            문의사항 답변, 개인 식별 , 불량 사용자의 부정 이용 방지와 비인가 사용 방지, 문의자 확인 등
                        </p>
                    </div>
                    <div class="article">
                        <h3 class="article__title">개인정보의 보유 및 이용기간</h3>
                        <p class="article__text">
                            “진주남강유등축제”는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유·이용기간 내에서 개인정보를 처리합니다. 이용자 개인정보는 원칙적으로 개인정보 수집 및 이용목적이 달성되면 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.
                        </p>
                        <ul class="list_style_dot">
                            <li>보존 항목 : 이름, 연락처(휴대폰 번호 및 일반 전화번호), E-mail 주소, 접속 로그인 , 접속 IP 정보</li>
                            <li>보존 근거 : 답변에 대한 근거 보존의 이유로 보존</li>
                            <li>보존 기간 : 문의내용 답변 후 12개월</li>
                        </ul>
                    </div>
                    <div class="article">
                        <h3 class="article__title">개인정보의 파기절차 및 방법</h3>
                        <p class="article__text">
                            “진주남강유등축제”는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.
                        </p>
                        <ul class="list_style_dot">
                            <li>파기절차 : 이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다.</li>
                            <li>파기기한 : 이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에,
                                개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가
                                불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.
                            </li>
                            <li>파기방법 : 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.</li>
                        </ul>
                    </div>
                    <div class="article">
                        <h3 class="article__title">개인정보 제공</h3>
                        <p class="article__text">
                            “진주남강유등축제”는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.
                        </p>
                        <ul class="list_style_dot">
                            <li>이용자들이 사전에 동의한 경우</li>
                            <li>법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
                        </ul>
                    </div>
                    <div class="article">
                        <h3 class="article__title">수집한 개인정보의 위탁</h3>
                        <p class="article__text">
                            “진주남강유등축제”는 사용자의 동의 없이 고객님의 정보를 외부 업체에 위탁하지 않습니다. 향후 그러한 필요가 생길 경우, 위탁 대상자와 위탁 업무 내용에 대해 고객님에게 통지하고 필요한 경우 사전 동의를 받도록 하겠습니다.
                        </p>
                    </div>
                    <div class="article">
                        <h3 class="article__title">개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항</h3>
                        <p class="article__text">
                            쿠키 등 인터넷 서비스 이용 시 자동 생성되는 개인정보를 수집하는 장치를 운영하지 않습니다.
                        </p>
                    </div>
                    <div class="article">
                        <h3 class="article__title">
                            개인정보 처리방침 변경
                        </h3>
                        <p class="article__text">
                            개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지합니다.
                        </p>
                    </div>
                    <div class="article">
                        <h3 class="article__title">
                            개인정보에 관한 민원서비스
                        </h3>
                        <p class="article__text">
                            “진주남강유등축제”는 고객의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보관리책임자를 지정하고 있습니다.
                        </p>
                        <ul class="list_style_dot">
                            <li>개인정보관리책임자 : 진주문화예술재단</li>
                            <li>전화번호 : 055)761-9111</li>
                        </ul>
                    </div>
                    <div class="article">
                        <p class="article__text">
                            기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.
                        </p>
                        <ul class="list_style_dot">
                            <li>개인정보침해신고센터 ( http://privacy.kisa.or.kr / 국번없이 118)</li>
                            <li>경찰청 사이버테러대응센터 (http://www.ctrc.go.kr / 국번없이 182)</li>
                        </ul>
                    </div>
                </div>
                <label class="privacy-agree">
                    <input type="checkbox" id="privacy-chk" checked> 개인정보 수집 및 이용 안내 동의
                </label>
            </div>
        </div>



        <c:set var="now" value="<%=new Date()%>"/>
        <div id="next" class="ydr-form-item-last">
            <p>상기 본인은 위와 같이 「진주남강유등축제 등(燈)공모대전」 참여를 신청합니다.</p>
            <p><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일"/></p>
            <p>신청자 <text id="sign">${app.name}</text></p>
        </div>
        <button class="ydr-btn a-alone form-btn" type="submit">수정하기</button>
    </section>
</form>
<script>

    var fileNum = 0;


    function chkForm(){
        var chk = $("input[id='privacy-chk']:checked").val();
        var file1 = $("input[name='file1']").val();
        var file2 = $("input[name='file2']").val();

        if(chk == undefined){
            alert("개인정보 수집 및 이용 안내에 동의하지 않으시면 신청이 제한됩니다.");
            return false;
        }

        if(file1 == ""){
            alert("출품서 및 출품원서를 제출해 주세요.");
            return false;
        }

        if(file2 == ""){
            alert("디자인 제안서를 제출해 주세요.");
            return false;
        }

        return true;
    }

    function deleteFile(target){
        $(target).parent().remove();
    }

    function fileCheck(file){
        var maxSize  = 50 * 1024 * 1024    //50MB
        var vFile = file.files[0];
        if(vFile === undefined){
            return false;
        }
        var fileSize = vFile.size;

        if(fileSize > maxSize) {
            alert("첨부파일 사이즈는 50MB 이내로 등록 가능합니다.");
            var agent = navigator.userAgent.toLowerCase();
            if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
                // ie 일때 input[type=file] init.
                $(file).replaceWith( $(file).clone(true) );
            } else {
                //other browser 일때 input[type=file] init.
                $(file).val("");
            }
            return false;
        }
        justSubmit(file);
    }

    function resetButton(target){

        var html = '<input type="file" class="postcode" onchange="fileCheck(this)">' +
            '<button type="button" class="post-button" onclick="justSubmit(this)">제출</button>'

        $(target).parent().parent().find(".hidden1").val("");
        $(target).parent().parent().find(".hidden2").val("");

        $(target).parent().empty().append(html);
    }

    function justSubmit(target){
        var form = new FormData();
        form.append( "file", $(target).parent().find("input[type='file']")[0].files[0] );
        form.append( "name", "${sName}${sMobileNo}");
        loaderTextChange("파일 업로드 중입니다. 잠시만 기다려 주세요.");
        loaderShow();
        $.ajax({
            type: "POST",
            url: "<c:url value="/file/upload"/>",
            processData : false,
            contentType : false,
            data: form,
            success: function(result){
                alert(result.message);
                loaderHide()
                if(result.status === "ok"){
                    var filename = result.file;
                    var path = result.path;

                    var html = '<a class="fileUploaded" href="https://d1td3ub34bocm1.cloudfront.net'+path+'" target="_blank" download>'+filename+'</a>' +
                        '<button type="button" class="post-button" onclick="resetButton(this)">다시제출</button>'

                    $(target).parent().parent().find(".hidden1").val(path);
                    $(target).parent().parent().find(".hidden2").val(filename);

                    $(target).parent().empty().append(html);
                }else {
                }
            },
            error: function (){
                alert("파일을 선택해 주세요.");
                loaderHide()
            }
        })
    }

    $("input[name='name']").on("change keyup paste", function (){
        $("#sign").text($(this).val());
    })

    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        yearSuffix: '년'
    });

    $(".hope").on("change", function (){
        if($(this).prop("checked")){
            $(this).parent().parent().addClass("active");
        }else {
            $(this).parent().parent().removeClass("active");
        }
    })

    $(function (){
        $("#date").datepicker({
            minDate: new Date('2022-05-01'),
            maxDate: new Date('2022-06-30')
        });
        $("#dateEnd").datepicker({
            minDate: new Date('2022-05-01'),
            maxDate: new Date('2022-06-30')
        });
        $(".datepicker").datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: 'c-100:c+0'
        });
    })

    $(".onlynumber").on("change keyup paste", function(){
        var str = $(this).val();
        str = str.replace(/[^0-9]/g,"");
        $(this).val(str);
    })
</script>
<jsp:include page="/footer"/>
