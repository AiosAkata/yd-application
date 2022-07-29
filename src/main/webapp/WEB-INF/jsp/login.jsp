<%--
  Created by IntelliJ IDEA.
  User: jhr
  Date: 2020-11-19
  Time: 오전 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/head"/>
<jsp:include page="/header"/>

<c:if test="${message ne null}">
    <script>
        alert("로그인 실패. 아이디 또는 비밀번호 오류입니다.");
    </script>
</c:if>

<div class="login-div">
    <div class="loginArea">

        <form name="loginForm" id="loginForm" action="<c:url value="/login"/>" method="post">
            <div class="loginInputArea ">
                <input type="text" name="username" id="username" value=""  placeholder="아이디" />
                <input type="password" name="password" id="password" value=""  placeholder="패스워드"/>
            </div>
            <div class="buttonArea03">
                <input type="submit" class="button05" value="로그인">
<%--                <input type="button" onclick="location.href='/join'" class="button06" value="회원가입">--%>
            </div>
        </form>

    </div>

    <script>
        function loginAct(){
            var frm	= $("#loginForm");

            if($("#username").val() == ''){
                alert("아이디를 입력해주세요.");
                $("#username").focus();
                return false;
            }else if($("#password").val() == ''){
                alert("패스워드를 입력해주세요.");
                $("#password").focus();
                return false;
            }

            return true;

        };

        $(document).ready(function() {
            $("#password").keydown(function(key) {
                if (key.keyCode == 13) {
                    loginAct();
                }
            });
        });

    </script>
</div>


<style>
    .loginArea { width : 400px; margin : 10em  auto;}
    .loginArea .logoArea { margin-bottom: 3em; text-align:center; }
    .loginArea .header-logo { color: #314695;font-weight: 700;font-size: 30px;line-height: 100px;margin-left: 5px; }
    .loginArea .header-logo .main-logo { float: left;height: 40px; margin-top: 30px;}
    .loginArea .loginInputArea input {width : 100%; margin-bottom: 0.5em;}
    .loginArea .buttonArea03 .button05{ border:none; width : 100%; background-color :#ff6200;  margin-top: 1em; height:42px; color:white; font-weight : bold;}
    .loginArea .buttonArea03 .button06{ border:none; width : 100%; background-color : #656565;  margin-top: 1em; height:42px; color:white; font-weight : bold;}
</style>
<jsp:include page="/footer"/>