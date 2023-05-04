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
<%@include file="../component/header.jsp"%>
<%@include file="../component/nav.jsp"%>
<div id="section">
    <form action="/board/save" method="post" enctype="multipart/form-data">
        제목 : <input type="text" id="board_title" name="boardTitle" placeholder="제목"><br>
        작성자 : <input type="text" id="board_writer" name="boardWriter" placeholder="작성자명"> <br>
        비밀번호 : <input type="text" id="board_pass" name="boardPass" placeholder="비밀번호"><br>
        내용 : <textarea name="boardContents" cols="30" rows="10"></textarea><br>
        파일 첨부 : <input type="file" name="boardFile" multiple><br>
        <input type="submit" value="글 작성">
    </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
</html>
