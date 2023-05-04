<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <style>
        #section a{
            display : block;
        }
    </style>
</head>
<body>
<%@include file="../component/header.jsp"%>
<%@include file="../component/nav.jsp"%>
<div id="section">
    <table>
        <tr>
            <th>id</th>
            <td>${board.id}</td>
        <tr>
            <th>writer</th>
            <td>${board.boardWriter}</td>
        </tr>
        <tr>
            <th>date</th>
            <td>
                <fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
            </td>
        </tr>
        <tr>
            <th>hits</th>
            <td>${board.boardHits}</td>
        </tr>
        <tr>
            <th>title</th>
            <td>${board.boardTitle}</td>
        </tr>
        <tr>
            <th>contents</th>
            <td>${board.boardContents}</td>
        </tr>
        <c:if test="${board.fileAttached == 1}">
            <tr>
                <th>image</th>
                <td>
                    <c:forEach items ="${boardFileList}" var="boardFile">
                    <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}"
                         alt="" width="100" height="100">
                    </c:forEach>
                </td>
            </tr>
        </c:if>
    </table>
    <button onclick="board_list()">목록</button>
    <button onclick="board_update()">수정</button>
    <button onclick="board_delete()">삭제</button>
    <button onclick="comment_write()">댓글 작성</button>
    <div id="comment-area"></div>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const board_list =()=>{
        location.href="/board/";
    }

    const board_update=()=>{
        const id='${board.id}'; // 보드의 아이디 변수 값을 가지고 와서 요청한다.
        location.href="/board/update?id="+id;
    }
    const board_delete=()=>{
        const id='${board.id}'; // 보드의 아이디 변수 값을 가지고 와서 요청한다.
        location.href="/board/delete-check?id="+id;
    }
    const comment_write=()=>{
        const commentarea = document.getElementById("comment-area")
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                id: "id",
                commentWriter: "commentWriter",
                boardId: "boardId",
                commentCreatedDate: "commentCreatedDate"
            },
            success: function(com){
                let comment ="<table>";
                comment+= "<tr>"
                comment+= "<td>"+com.id+"<td>"
                comment+= "<td>"+com.commentWriter+"<td>"
                comment+= "<td>"+com.commentContents+"<td>"
                comment+= "<td>"+com.commentCreatedDate+"<td>"
                comment+= "</tr>"
                comment+="</table>";
                commentarea.innerHTML= comment;
            },
            error:function(com){
                commentarea.innerHTML="댓글이 없습니다.";
            }
        })

    }
</script>
</html>
