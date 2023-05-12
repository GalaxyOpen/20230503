<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <%-- 모멘트 라이브러리 --%>

    <style>
        #section a{
            display : block;
        }
        comment-area{
            align-content: center;
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



    <div id="comment-area">
        <input type="text" id="comment-writer" placeholder="댓글 작성자">
        <input type="text" id="comment-contents" placeholder="댓글 내용">
        <button onclick="comment_write()">댓글 작성</button>
    </div>
    <div id="comment-list">
        <c:choose>
            <c:when test="${commentList == null}">
                <h2>작성된 댓글이 없습니다.</h2>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>id</th>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성시간</th>
                    </tr>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.id}</td>
                            <td>${comment.commentWriter}</td>
                            <td>${comment.commentContents}</td>
                            <td>
                                <fmt:formatDate value="${comment.commentCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                            </td>
                        </tr>

                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const board_list =()=>{
        const type = '${type}';
        const q = '${q}';
        const page = '${page}';
        location.href="/board/paging?page="+page+"&type"+type+"&q"+q;
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
        const commentWriter=document.getElementById("comment-writer").value;
        const commentContents = document.getElementById("comment-contents").value;
        const boardId = '${board.id}'
        const result = document.getElementById("comment-list");
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
               "commentContents" : commentContents,
               "commentWriter" :  commentWriter,
               "boardId" : boardId
            },
            success: function(com){
                console.log(com);
                let output ="<table>";
                output+= "<tr>"
                output+= "<th>id</th>"
                output+= "<th>작성자</th>"
                output+= "<th>내용</th>"
                output+= "<th>작성시간</th>"
                output+= "</tr>"
                for(let i in com){
                    output +="<tr>";
                    output +="<td>"+com[i].id + "</td>";
                    output +="<td>"+com[i].commentWriter +"</td>";
                    output +="<td>"+com[i].commentContents+"</td>";
                    output +="<td>"+moment(com[i].commentCreatedDate).format("YYYY-MM-DD HH:mm:ss")+"</td>";
                    output +="</tr>"
                }
                output+="</table>";
                result.innerHTML = output;
                document.getElementById("comment-writer").value="";
                document.getElementById("comment-contents").value="";
            },
            error:function(com){
                console.log("실패");
            }
        })

    }
</script>
</html>
