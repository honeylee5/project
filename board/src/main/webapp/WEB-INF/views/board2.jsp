<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>project</title>
    <link rel="stylesheet" href="<c:url value='/css/bg.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        
        form {
            padding:0px 20px 20px 20px;
       	    border-radius: 0 0 10px 10px;
            background-color:#ffffff;
        } 

        .container {
            width : 50%;
            margin : auto;
        	background-color:#ffffff;
        	border: 2px solid rgb(89,117,196);
        	border-radius: 10px;
        }

        .writing-header {
            position: relative;
            margin: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
        }

        input {
            width: 100%;
            height: 35px;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }

        textarea {
            width: 100%;
            background: #f8f8f8;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }

        .frm {
            width:100%;
        }
        .btn {
            background-color: rgb(236, 236, 236); /* Blue background */
            border: none; /* Remove borders */
            color: black; /* White text */
            padding: 6px 12px; /* Some padding */
            font-size: 16px; /* Set a font size */
            cursor: pointer; /* Mouse pointer on hover */
            border-radius: 5px;
        }

        .btn:hover {
            text-decoration: underline;
        }
        
        .major {
            position: relative;
            border: 2px solid rgb(89,117,196);
            border-bottom-style: none;
            padding: 20px;
        	border-radius: 10px 10px 0 0;
            background-color:#ffffff;
            border-bottom: 1px solid #323232;
        }
        
        .combined {
            padding: 20px;
            border: 2px solid rgb(89,117,196);
            border-top-style: none;
        }
        
        .comment {
            padding-top : 50px;
            padding-left : 25%;
            padding-right : 25%;
        }
    </style>
</head>
<body>
<div id="menu">
    <jsp:include page="header.jsp"/>
</div>
<script>
    let msg = "${msg}";
    if(msg=="WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.");
    if(msg=="MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>
<div class="container">
    <h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2> <%--mode가 new면 글쓰기, 아니면 읽기--%>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="bno" value="${boardDto.bno}">

        <input name="title" type="text" value="${boardDto.title}" placeholder="  제목을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}><br>
        <textarea name="content" rows="20" placeholder=" 내용을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}>${boardDto.content}</textarea><br>

        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
        </c:if>
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 글쓰기</button>
        </c:if>
        <c:if test="${boardDto.writer eq loginId}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> 수정</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> 삭제</button>
        </c:if>
        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록</button>
    </form>
</div>

 <section class="comment">
	<header class="major" style="text-align:left;">
		<h2>댓글</h2>
		<p>여러분의 소중한 댓글을 작성해주세요.</p>
	</header>
	<form method="post" action="#" class="combined" style="width:auto;">
		<textarea name="replyComment" id="replyComment" placeholder="비속어를 사용하지 말아주세요." class="invert" rows="5" style="border-radius:0; resize:none;"></textarea>
		<input id="register" type="button" class="primary" value="+ 등록" style="font-weight: 900;"/>
	</form>
	<form id="replies" class="combined" style="flex-direction:column; margin:0; display:contents;">
	</form>
</section>
<script>
    /* let bno = ${boardDto.bno}; */
    
    $(document).ready(function(){
        let formCheck = function() {
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }

            if(form.content.value=="") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }

        $("#writeNewBtn").on("click", function(){
            location.href="<c:url value='/board/write'/>";
        });

        $("#writeBtn").on("click", function(){
            let form = $("#form");
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");

            if(formCheck())
                form.submit();
        });

        $("#modifyBtn").on("click", function(){
            let form = $("#form");
            let isReadonly = $("input[name=title]").attr('readonly');

            // 1. 읽기 상태이면, 수정 상태로 변경
            if(isReadonly=='readonly') {
                $(".writing-header").html("게시판 수정");
                $("input[name=title]").attr('readonly', false);
                $("textarea").attr('readonly', false);
                $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
                return;
            }

            // 2. 수정 상태이면, 수정된 내용을 서버로 전송
            form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if(formCheck())
                form.submit();
        });

        $("#removeBtn").on("click", function(){
            if(!confirm("정말로 삭제하시겠습니까?")) return;

            let form = $("#form");
            form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
            form.attr("method", "post");
            form.submit();
        });

        $("#listBtn").on("click", function(){
            location.href="<c:url value='/board/list${searchCondition.queryString}'/>";
        });
        
        // 댓글등록
        $("#register").click(function(){
        	let replyComment = $("textarea[name=replyComment]").val();
        	let bno = "1";
            let pcno = $("#replyForm").parent().attr("data-pcno");

            if(replyComment.trim()==''){
                alert("댓글을 입력해주세요.");
                $("input[name=replyComment]").focus()
                return;
            }
            
            $.ajax({
                type:'POST',                      // 요청 메서드
                url: '/board/comments?bno='+bno,  // 요청 URI
                headers : { "content-type": "application/json"},  // 요청 헤더
                data : JSON.stringify({pcno:pcno, bno:bno, replyComment:replyComment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){ // 등록이 새로 되었으니
                    alert(result);
                    showList(bno);          // 댓글목록이 갱신되었는지 보여주기 위해
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()

            $("#replyForm").css("display", "none")
            $("input[name=replyComment]").val('')
            $("#replyForm").appendTo("body");
        });
    });
    
    
</script>
</body>
</html>