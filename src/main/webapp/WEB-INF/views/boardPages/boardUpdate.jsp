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
<h2>글 수정</h2>
    <form action="/board/update" method="post" name="updateForm">
        글번호 : <input type="text" name="id" value="${board.id}" readonly><br>
        글 제목 : <input type="text" name="boardTitle" placeholder="수정할 글 제목"><br>
        작성자 : <input type="text" name="boardWriter" value="${board.boardWriter}" readonly><br>
        글 비밀번호 : <input type="text" id="boardPass" name="boardPass"><br>
        글 내용 : <textarea name="boardContents"  cols="30" rows="10">${board.boardContents}</textarea>
        <input type="button" onclick="update_check()" value="수정">
    </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const update_check = () => {
        const inputValue=document.getElementById("boardPass").value;
        const DBValue = '${board.boardPass}';
        if(inputValue == DBValue) {
           document.updateForm.submit();
        }else {
            alert("비밀번호가 일치하지 않습니다.")
        }
    }

</script>
</html>
