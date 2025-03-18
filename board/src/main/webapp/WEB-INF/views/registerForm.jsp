<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value='/css/bg.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * { box-sizing:border-box; }
        form {
            width:400px;
            height:600px;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid rgb(89,117,196);
            border-radius: 10px;
            background-color:#ffffff;
        }
        .input-field {
            width: 300px;
            height: 40px;
            border : 1px solid rgb(89,117,196);
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }

        label {
            width:300px;
            height:30px;
            margin-top :4px;
        }
        #submit {
            background-color: rgb(89,117,196);
            color : white;
            width:300px;
            height:50px;
            font-size: 17px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
        }
        .title {
            font-size : 50px;
            margin: 10px 0 10px 0;
        }
        .msg {
            height: 30px;
            text-align:center;
            font-size:16px;
            color:red;
            margin-bottom: 20px;
        }

        .sns-chk {
            margin-top : 5px;
        }
    </style>
    <title>Register</title>
</head>
<body>
<div id="menu">
    <jsp:include page="header.jsp"/>
</div>
<form action="<c:url value="/register/join"/>" method="post" name="form" onsubmit="return formCheck(this);">
    <div class="title">Register</div>
    <div id="msg" class="msg"><form:errors path="id"/></div>
    <label for="">아이디</label>
    <input class="input-field" type="text" name="id" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label for="">비밀번호</label>
    <input class="input-field" type="password" name="pwd" id="pwd" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label for="">비밀번호 확인</label>
    <input class="input-field" type="password" name="pwd2" id="pwd2" placeholder="8~12자리의 영대소문자와 숫자 조합"> 
    <span id="result"></span>
    <label for="">이름</label>
    <input class="input-field" type="text" name="name" placeholder="홍길동">
    <label for="">이메일</label>
    <input class="input-field" type="text" name="email" placeholder="example@naver.co.kr">
    <label for="">생일</label>
    <input class="input-field" type="text" name="birth" placeholder="2020-12-31">
    <div class="sns-chk">
        <label><input type="checkbox" name="sns" value="facebook"/>페이스북</label>
        <label><input type="checkbox" name="sns" value="kakaotalk"/>카카오톡</label>
        <label><input type="checkbox" name="sns" value="instagram"/>인스타그램</label>
    </div>
    <input id="submit" type="submit" value="회원 가입" onclick="formSubmit()">
</form>    

<script>
    function formCheck(frm) {
        let msg ='';
        if(frm.id.value.length<3) {
            setMessage('id의 길이는 3이상이어야 합니다.', frm.id);
            return false;
        }
        return true;
    }
    
    function setMessage(msg, element){
        document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
        if(element) {
            element.select();
        }
    }
    
	 // 비밀번호 확인
	$(document).ready(function(){
		$('#pwd2').keyup(function(){
    		var pass1 = $('#pwd').val();
    		var pass2 = $('#pwd2').val();

    		if(pass1 == pass2)
        		$('#result').html("비밀번호가 일치합니다").css('color',"green");
    		else
        		$('#result').html("비밀번호가 일치하지 않습니다").css('color','red');
    		    return;
		});    
		
	});
    
    // 유효성검사
    function formSubmit() {
    	var form = document.form;
        alert("111");
    	
    	form.submit(); // 폼 제출
    }	
    /* $("#join").on("click", function(){
    	//if (){
        	location.href="<c:url value='/register/add'/>";
    	//}
    }); */
</script>
</body>
</html>