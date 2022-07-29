<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="/head"/>
<body>
<div id="wrap" class="sub">
    <jsp:include page="/header"/>
    <div class="error-wrap">
        <div id="container">
            <div class="clearfix">
                <div class="tit">
                    <p class="">페이지를 찾을 수 없습니다.</p>
                </div>
                <div class="con">
                    <p>
                        존재하지 않는 주소를 입력하셨거나,
                        요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.
                        입력하신 주소가 정확한지 다시 한 번 확인해주세요.
                    </p>

                    <a class="btn-st" href="javascript:void(0);" onclick="history.back(-1);">
                        <span class="pa-center">이전 페이지</span>
                    </a>

                </div>

            </div>
        </div>
    </div>

</div>
</div>
<jsp:include page="/footer"/>
</body>
</html>
