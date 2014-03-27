<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>New PT-Discount Confirmed</title>
<link href="${ctx}/static/styles/main.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<form action="${ctx}/traiff/query" method="post" id="tariffForm" method="post" enctype='multipart/form-data'>
	<div style="padding:5px;">
<table class="table_A">
        <thead>
             <tr>
                <td style="text-align:center;">Product</td>
                <td>
                	 <select name="productId" value="${productId}">
		                <c:forEach items="${productList}" var="product" begin="0">
								<option value="${product.id}" <c:if test="${product.id==productId}">selected</c:if> >${product.product}</option>
						</c:forEach>
					</select>
                </td>
                <td style="text-align:center;">Zone Type</td>
                <td>
                	<select name="zoneTypeId" value="${zoneTypeId}">
		                <c:forEach items="${zoneTypeList}" var="zoneType" begin="0">
								<option value="${zoneType.id}" <c:if test="${zoneType.id==zoneTypeId}">selected</c:if> >${zoneType.zoneType}</option>
						</c:forEach>
					</select>
                </td>
				 <td style="text-align:center;">Term Of Payment</td>
                <td>
                	<select name="payment" value="${payment}">
						  <option value="ReceivePay" <c:if test="${payment eq 'ReceivePay'}">selected</c:if> >ReceivePay</option>
						  <option value="SenderPay" <c:if test="${payment eq 'SenderPay'}">selected</c:if> >SenderPay</option>
					</select>
                </td>				
            </tr>
            <tr>
            	<td colspan="3" align="left">
            		<input type="file" id="myfile" name="myFile" />
            		<input type="button" id="upload" value="upload" class="cls-button"/>
           		</td>
            	<td colspan="3" align="right">
            	<input type="submit" value="query" class="cls-button"/>
            		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	</tr>
        </thead>
    </table>
</div>
<div style="padding:0 5px 5px 5px;">
<h4 style="float:left">FullTariffmaintenance List</h4>
<div class="clearboth"></div>
<table class="table_B" width="100%">
        <thead>
            <tr>
                <th >weight</th>
                <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${tariffGroupList}" var="tariffGroup">
				<tr>
					<td>${tariffGroup.weight}</td>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
							<c:set var="key">${tariffGroup.id}_${zoneGroup.id}</c:set>
						     <td><input id="zg_${key}" name="zg_${key}" value="${traiffMap[key]}" size="4"/></td>
				   </c:forEach>
			   </tr>
			</c:forEach>
        </tbody>
    </table>
   <br>    
    <div align="right" >
		
     <input type="button" value="Save" class="cls-button" onclick="save();" id="save"/>
    	
</form>
</div>
<script type="text/javascript">
	$(function(){
	    $("#upload").click(function(){
	        //序列化表单元素，返回json数据
	        $("#tariffForm").attr("action","${ctx}/traiff/upload");
	        $("#tariffForm").submit();
	    });
	});

    $(function(){
        $("#save").click(function(){
            //序列化表单元素，返回json数据
            var params = $("tbody").find("input").serializeArray();
            var jsonString = O2String(params);
            $.ajax({
                type:"POST",
                url:"${ctx}/traiff/add",
                dataType:"json",      
                contentType:"application/json",   
                data:jsonString,
                success:function(data){
                    alert("saved success");
                    $("#tariffForm").submit();
                    //window.location.href="${ctx}/discount/init";
                },
                error:function(e) {
                    alert("error："+e);
                }
            });
        });
    });

    var O2String = function (O) {
        //return JSON.stringify(jsonobj);
        var S = [];
        var J = "";
        if (Object.prototype.toString.apply(O) === '[object Array]') {
            for (var i = 0; i < O.length; i++)
                S.push(O2String(O[i]));
            J = '[' + S.join(',') + ']';
        }
        else if (Object.prototype.toString.apply(O) === '[object Date]') {
            J = "new Date(" + O.getTime() + ")";
        }
        else if (Object.prototype.toString.apply(O) === '[object RegExp]' || Object.prototype.toString.apply(O) === '[object Function]') {
            J = O.toString();
        }
        else if (Object.prototype.toString.apply(O) === '[object Object]') {
            for (var i in O) {
                O[i] = typeof (O[i]) == 'string' ? '"' + O[i] + '"' : (typeof (O[i]) === 'object' ? O2String(O[i]) : O[i]);
                S.push(i + ':' + O[i]);
            }
            J = '{' + S.join(',') + '}';
        }
        return J;
 };
     
</script>
</body>
</html>
