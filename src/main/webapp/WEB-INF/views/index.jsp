<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%@include file="component/header.jsp"%>
<%@include file="component/nav.jsp"%>
<div id="section">
    <a href="/board/save">boardSave</a>
    <a href="/board/">boardList</a>
    <a href="/board/paging">페이징목록</a>

</div>
<%@include file="component/footer.jsp"%>
</body>
</html>
