<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<!DOCTYPE html>
<script> 
    function confirmLogout() {        
	     if(confirm("정말 로그아웃 하시겠습니까?")) { 
	         alert('로그아웃 되었습니다.');   
	     }    
	}    
</script>

<div id="menu">
    <ul>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/read'/>">Board</a></li>
        <%-- <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li> --%>
        <c:choose>
        <c:when test="${loginId eq ''}">
        <li>
            <a href="<c:url value='${loginOutLink}'/>">${loginOut}</a>
        </li>
        <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
        </c:when>
        <c:otherwise>
        <li>       
            <a href="<c:url value='${loginOutLink}'/>" onclick = 'confirmLogout()'>${loginOut}</a>
        </li>
        </c:otherwise>
        </c:choose>
    </ul>
</div>