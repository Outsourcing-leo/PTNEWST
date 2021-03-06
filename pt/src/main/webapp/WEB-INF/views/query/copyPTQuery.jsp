<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PT Query</title>
<link href="${ctx}/static/styles/main.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/js/calendar.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready(function(){

	/*$(".datepicker").datePicker({
		inline:true,
		selectMultiple:false
	});

	$("#datepicker").datePicker({
		clickInput:true
	});*/

});
</script>
<form action="${ctx}/ptQuery/queryPT" method="post" id="ptQueryForm" target="_self">

<div>
<div style="padding:0 5px 5px 5px;">
<h4 style="float:left">PT List</h4>
<div class="clearboth"></div>
<table class="table_B" width="100%">
        <thead>
			<tr>
                <th>PT Application Reference#</th>
                <th>Application date</th>
                <th>Account #</th>
                <th>Customer Name</th>
                <th>Depot</th>
                <th>Channel</th>
                <th>ToP</th>
                <th>Terrotory</th>
                <th>Status</th>
                <th>Operation</th>
            </tr>
        </thead>
        <tbody>
             <c:forEach items="${businessList}" var="business">
				<tr>
					<td>${business.applicationReference}</td>
					<td><fmt:formatDate  value="${business.applicationDate}" pattern="yyyy-MM-dd"></fmt:formatDate ></td>
					<td>${business.account}</td>
					<td>${business.cusName}</td>
					<td>${business.depotCode}</td>
					<td>${business.channel}</td>
					<td>${business.consStop}</td>
					<td>${business.description}</td>
					<td>${business.state}</td>
	                <td><a id="appeal" href="#" onclick="copy('${business.id}')">copy</a></td>
			   </tr>
			</c:forEach>
        </tbody>
    </table>
    <%@ include file="/WEB-INF/tags/navigate.jsp"%>
  <br>    
</form>
</div>
<script type="text/javascript">
    $(function(){
        $("#query").click(function(){
         $("#ptQueryForm").submit();
        });
       
    });

    function copy(val){
    	 $.ajax({
             type:"POST",
             url:"${ctx}/ptCreate/copyCustomer/"+val,
             dataType:"text",      
             contentType:"application/json",   
             success:function(data){
            	 window.returnValue = data;
             	 window.close();
             },
             error:function(e) {
                 alert("error："+e);
             }
         });
	}
</script>
</body>
</html>