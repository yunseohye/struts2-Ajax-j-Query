<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.news{
	font-size: 10pt;
	display: block; 
	margin: 0 auto;
	background: yellow;
	color: blue;
	border: 1px dashed black;
	width: 50%;
}

</style>

<script type="text/javascript" src="<%=cp%>/data/js/ajaxUtil.js"></script>
<script type="text/javascript">

	function newsTitle() {
		sendRequest("newsTitleJSON_ok.jsp",null,displayTitle,true);
		setTimeout("newsTitle()",3000);
		
	}
	function displayTitle() {
		
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){
				
				var jsonStr = httpRequest.responseText;
				//alert(jsonStr);
			
			//eval은 변수를 javascript의 함수처럼 사용하는 명령어
			var jsonObject = window.eval('('+jsonStr+')');
			//alert(jsonObject); //object
			//alert(jsonObject.count); //4
			//alert(jsonObject.titles[2].publisher); 
			
			var count = jsonObject.count;
			
			if(count>0) {
				
				var htmlData = "<ol>";
				
				for(var i=0;i<jsonObject.titles.length;i++) {
					
					var publisherStr = jsonObject.titles[i].publisher;
					var headlineStr =  jsonObject.titles[i].headline;
					
					htmlData += "<li>" + headlineStr +
					" [" + publisherStr + "]</li>";
				}
				
				htmlData += "</ol>";
				
				var newsDiv = document.getElementById("newsDiv");
				newsDiv.innerHTML = htmlData;
				
				}
			}
		}	
	}		
	window.onload = function() {
		newsTitle();
	}

</script>
</head>
<body>
<h2>헤드라인 뉴스</h2>
<hr/>
<br/>

<div style="width: 50%; margin: 0 auto;">뉴스보기</div>
<div id="newsDiv" class="news"></div>
</body>
</html>