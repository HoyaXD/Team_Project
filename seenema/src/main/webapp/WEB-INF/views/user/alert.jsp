<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/04
  Time: 9:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <script>
		var message = "${msg}";
		var url = "${url}";
		alert(message);
		document.location.href = url;
	</script>
</body>
</html>
