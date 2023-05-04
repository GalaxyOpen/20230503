<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="footer">

</div>
<script>
    const date = new Date();
    console.log(date);
    console.log(date.getFullYear());
    const footer = document.getElementById("footer");
    footer.innerHTML = "<p>&copy; " + date.getFullYear() + "&nbsp; HRDKOREA  All rights reserved. </p>";
</script>