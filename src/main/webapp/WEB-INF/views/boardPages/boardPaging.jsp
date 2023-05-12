<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="/resources/css/bootstrap.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>

<div id="section">

  <div class="container" id="search-area">
    <form action="/board/paging" method="get">
      <select name="type">
        <option value="boardTitle">제목</option>
        <option value="boardWriter">작성자</option>
      </select>
      <input type="text" name="q" placeholder="검색어를 입력하세요">
      <input type="submit" value="검색">
    </form>
  </div>

  <div class="container" id="list">
    <table class="table table-striped table-hover text-center">
      <tr>
        <th>id</th>
        <th>title</th>
        <th>writer</th>
        <th>date</th>
        <th>hits</th>
      </tr>
      <c:forEach items="${boardList}" var="board">
        <tr>
          <td>${board.id}</td>
          <td>
            <a href="/board?id=${board.id}&page=${paging.page}&q=${q}&type=${type}">${board.boardTitle}</a>
          </td>
          <td>${board.boardWriter}</td>
          <td>
            <fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
          </td>
          <td>${board.boardHits}</td>
        </tr>
      </c:forEach>
    </table>
  </div>
  <div class="container">
    <ul class="pagination justify-content-center">
      <c:choose>
        <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
        <c:when test="${paging.page<=1}">
          <li class="page-item disabled">
            <a class="page-link">[이전]</a>
          </li>
        </c:when>
        <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
        <c:otherwise>
          <li class="page-item">
            <a class="page-link" href="/board/paging?page=${paging.page-1}&q=${q}&type${type}">[이전]</a>
          </li>
        </c:otherwise>
      </c:choose>
<%-- 중간페이지 설명 ↓ --%>
      <%--  for(int i=startPage; i<=endPage; i++) <= 바로 아랫줄 for:each구문 설명한 것.      --%>
      <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
        <c:choose>
          <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
          <c:when test="${i eq paging.page}">
            <li class="page-item active">
              <a class="page-link">${i}</a>
            </li>
          </c:when>

          <c:otherwise>
            <li class="page-item">
              <a class="page-link" href="/board/paging?page=${i}&q=${q}&type${type}">${i}</a>
            </li>
          </c:otherwise>
        </c:choose>
      </c:forEach>
<%--[다음]에 대한 주석 처리 ↓--%>
      <c:choose>
        <c:when test="${paging.page>=paging.maxPage}">
          <li class="page-item disabled">
            <a class="page-link">[다음]</a>
          </li>
        </c:when>
        <c:otherwise>
          <li class="page-item">
            <a class="page-link" href="/board/paging?page=${paging.page+1}&q=${q}&type${type}">[다음]</a>
          </li>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
</div>
<%@include file="../component/footer.jsp" %>
</body>
</html>