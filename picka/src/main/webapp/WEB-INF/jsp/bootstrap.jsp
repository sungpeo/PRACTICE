<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="http://code.jquery.com/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.3/jquery.mobile.min.js"></script>
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
    <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.3/jquery.mobile.min.css">
    <title>TEST</title>
</head>
<body>
	
	<div data-role="page">
	  <div data-role="header">
	    <h1>헤더</h1>
	  </div>
	  
	  <div data-role="content">
	    <div id="banner">
	      <h2>배너</h2>
	    </div>
	    <p>다람쥐 헌 쳇바퀴에 타고파.</p>
	    <ul data-role="listview" data-inset="true">
	      <li><a href="#">안녕</a></li>
	      <li><a href="#">친구들</a></li>
	    </ul>
	    
	    <!-- Single button -->
		<div class="btn-group">
		  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
		    Action <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="#">Action</a></li>
		    <li><a href="#">Another action</a></li>
		    <li><a href="#">Something else here</a></li>
		    <li class="divider"></li>
		    <li><a href="#">Separated link</a></li>
		  </ul>
		  
		</div>
	  </div>
	  
	  <div data-role="footer">
	    <h4>푸터</h4>
	  </div>
	</div>
	
</body>
</html>