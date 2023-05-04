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
    <h2>글 삭제</h2>

        <h2>삭제를 위하여 글에 지정한 비밀번호를 입력하여 주세요. </h2>
        글 비밀번호 : <input type="text" id="board_Pass" name="boardPass"><br>
        <input type="button" onclick="delete_check()" value="삭제">

</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    const delete_check = () => {
        const inputValue=document.getElementById("board_Pass").value;
        const DBValue = '${board.boardPass}';
        const id='${board.id}';
        if(inputValue == DBValue) {
            location.href="/board/delete?id="+id;
        }else {
            alert("비밀번호가 일치하지 않습니다. ")
        }
    }

</script>
</html>
