<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<h2>게시판 리스트</h2>
    <table>
        <tr>
            <th>번호</th>
            <th>글 제목</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th>작성내용</th>
        </tr>
        <c:forEach items="${boardList}" var="board">
            <tr>
                <td>${board.id}</td>
                <td><a href="/board?id=${board.id}">${board.boardTitle}</a></td>
                <td>${board.boardWriter}</td>
                <td>${board.boardCreatedDate}</td>
                <td>${board.boardContents}</td>
            </tr>
        </c:forEach>
    </table>

</div>
<%@include file="../component/footer.jsp"%>
</body>

</html>
