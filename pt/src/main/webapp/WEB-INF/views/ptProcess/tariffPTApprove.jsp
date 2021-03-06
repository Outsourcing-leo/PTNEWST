<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>New PT-Summary Info</title>
<link href="${ctx}/static/styles/main.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/tab.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctx}/uploadify/uploadify.css" type="text/css"></link>
<script type="text/javascript" src="${ctx}/uploadify/jquery.uploadify-3.1.min.js"></script>
</head>
<style type="text/css">	
		.tab tr td {font-size:12px;
					align:left;
			}	
	
		</style>

<body>
<form action="#">
<div style="padding:5px;">
  <h4 class="title">PT Tariff Info</h4>
  <table class="table_A">
  <tr>
  <td width="20%" align="left"><b>PT Approval Ref NO. &nbsp; :</b></td>
  <td align="left"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;${business.applicationReference}</td>
  </tr>
  <tr></tr>
  <tr> <td colspan="2"><b>Customer & Shipping Profile</b></td></tr>
  </table>
  <table class="tab">
    <tr>
      <td>Customer Name :</td>
      <td width="40%">${customer.cusName}</td>
	  <td width="20%">Account # :</td>
      <td>${customer.account}</td>
    </tr>
    <tr>
      <td>Origin Depot :</td>
      <td>${business.depotCode}		</td>
      <td>Average Weight per Consignment :</td>
      <td></td>
    </tr>
    <tr>
	  <td width="20%">Projected Monthly Revenue in CNY: </td>
      <td colspan="3">220</td>
    </tr>
  </table>
  <b>Loading Details</b>
  <table>
    <tr>
      <td  width="20%">Division :</td>
      <td  width="40%">G</td>
      <td  width="20%">RateCategory :</td>
      <td>07PTO</td>
    </tr>
    <tr>
      <td>Approval Date :</td>
      <td>30-Oct-08</td>
      <td>Effective Date :</td>
      <td>${business.effectiveDate}</td>
    </tr>
    <tr>
      <td>End Date :</td>
      <td>Open</td>
      <td>Review Date :</td>
      <td>Open</td>
    </tr>
    <tr>
      <td>Product :</td>
      <td>15D/12D/10D/09D</td>
      <td>Terms of Payment :</td>
      <td>${customer.payment}</td>
    </tr>
	<tr>
      <td>Option :</td>
      <td>No discount for potions!</td>
      <td>Currency :</td>
      <td>CNY</td>
    </tr>
    <tr>
      <td>Zoning :</td>
      <td>Set Default</td>
      <td>Fuel Surchange :</td>
      <td>FSI according to public fuel surchange</td>
    </tr>
    </table>
  </div>
 <br />
 <c:if test="${flag=='Both'}">
	<div style="padding:0;" id="tabsI">
	  <ul>
	    <li><a href="#" onclick="tabPageControl(0)" title="Sender Pay" id="sp" class="activeBack"><span id="sps" class="activeSpan">Sender Pay</span></a></li>
	    <li><a href="#" onclick="tabPageControl(1)" title="Recieve Pay" id="rp"><span id="rps">Recieve Pay</span></a></li>
	  </ul>
	</div>
</c:if>
<div style="padding:5px;" id="tabPagesContainer">
<div class="tabPageSelected" id="sedDIV">
	<div style="padding:0;" id="tabsI">
	  <ul>
	    <li><a href="#" onclick="tabControl(0)" title="Discount Profile"  id="a0" class="activeBack"><span id="s0" class="activeSpan">Discount Profile</span></a></li>
	    <li><a href="#" onclick="tabControl(1)" title="Heavy Weight Rate" id="a1"><span id="s1">Heavy Weight Rate</span></a></li>
	    <li><a href="#" onclick="tabControl(2)" title="Consignment Profile" id="a2"><span id="s2">Consignment Profile</span></a></li>
	  </ul>
	</div>
<div class="tabPageSelected" id="disDIV">
 <table>
 <tr>
 <td style="background-color:#F5C07B">Summary </td><td style="background-color:#EFEFEF">Rev(CNY)</td><td>${zoneSummary.revM}/M</td>
 <td>${zoneSummary.revY}/Y</td><td style="background-color:#EFEFEF">Cons</td><td>${zoneSummary.consM}/M</td><td>${zoneSummary.consY}/Y</td>
  <td style="background-color:#EFEFEF">Kilo(kg) </td><td>${zoneSummary.kiloM}/M</td><td>${zoneSummary.kiloY}/Y</td>
 </tr>
 </table>
<br/>
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="25" style="text-align:left;">Discounts Profile-15D/12D/10D/09D</th>
            </tr>
            <tr>
                <th rowspan="2">Weightband</th>
                <th rowspan="2">Inc</th>
                <th rowspan="2">Add On</th>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th colspan="2">${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
            <tr>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>Base</th>
						<th>Int</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${documentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<td>${weightBand.addOnWeightInt}kg</td>
					<c:if test="${weightBand.type=='base'}">
						<td align="center">N</td>
					</c:if>
					<c:if test="${weightBand.type=='add'}">
						<td align="center">Y</td>
					</c:if>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
					    <c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<c:if test="${weightBand.type=='base'}">
							<td>${discountMap[key]}%</td>
						</c:if>
						<c:if test="${weightBand.type=='add'}">
							<td></td>
						</c:if>
						<td>${discountMap[key]}%</td>	
				   </c:forEach>
			   </tr>
			</c:forEach>
          </tbody>
</table>
<br />
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="25" style="text-align:left;">Discounts Profile-15N/12N/10N/09N</th>
            </tr>
            <tr>
                <th rowspan="2">Weightband</th>
                <th rowspan="2">Inc</th>
                <th rowspan="2">Add On</th>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th colspan="2">${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
            <tr>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>Base</th>
						<th>Int</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${ndocumentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<td>${weightBand.addOnWeightInt}kg</td>
					<c:if test="${weightBand.type=='base'}">
						<td align="center">N</td>
					</c:if>
					<c:if test="${weightBand.type=='add'}">
						<td align="center">Y</td>
					</c:if>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
					    <c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<c:if test="${weightBand.type=='base'}">
							<td>${discountMap[key]}%</td>
						</c:if>
						<c:if test="${weightBand.type=='add'}">
							<td></td>
						</c:if>
						<td>${discountMap[key]}%</td>	
				   </c:forEach>
			   </tr>
			</c:forEach>
          </tbody>
</table>
<br>
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="25" style="text-align:left;">Discounts Profile-48N</th>
            </tr>
            <tr>
                <th rowspan="2">Weightband</th>
                <th rowspan="2">Inc</th>
                <th rowspan="2">Add On</th>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th colspan="2">${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
            <tr>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>Base</th>
						<th>Int</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
           <c:forEach items="${economyList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<td>${weightBand.addOnWeightInt}kg</td>
					<c:if test="${weightBand.type=='base'}">
						<td align="center">N</td>
					</c:if>
					<c:if test="${weightBand.type=='add'}">
						<td align="center">Y</td>
					</c:if>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
					    <c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<c:if test="${weightBand.type=='base'}">
							<td>${discountMap[key]}%</td>
						</c:if>
						<c:if test="${weightBand.type=='add'}">
							<td></td>
						</c:if>
						<td>${discountMap[key]}%</td>	
				   </c:forEach>
			   </tr>
			</c:forEach>
        </tbody>
    </table>
</br>
</div>
<div class="tabPageUnSelected" id="conDIV">
<table class="table_B" width="100%">
        <thead>
						<tr align="center">
                <th colspan="14" style="text-align:left;">Consignmengt Profile- 15D/12D/10D/09D</th>
            </tr>
            <tr>
                <th>Weightband</th>
                 <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th ondblclick="setSpecificConsignmentSet(${zoneGroup.id},${zoneType.document});">${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${documentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<td>${consignmentMap[key]}</td>
				   </c:forEach>
			   </tr>
			</c:forEach>
          </tbody>
</table>
<br>
<table class="table_B" width="100%">
        <thead>
						<tr align="center">
                <th colspan="14" style="text-align:left;">Consignmengt Profile- 15N/12N/10N/09N</th>
            </tr>
            <tr>
                <th>Weightband</th>
                <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
           <c:forEach items="${ndocumentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<td>${consignmentMap[key]}</td>
				   </c:forEach>
			   </tr>
			  </c:forEach>
          </tbody>
</table>
<table class="table_B" width="100%">
        <thead>
						<tr align="center">
                <th colspan="14" style="text-align:left;">Consignmengt Profile- 48N</th>
            </tr>
            <tr>
                <th >Weightband</th>
                <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
             <c:forEach items="${economyList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<td>${consignmentMap[key]}</td>
				   </c:forEach>
			   </tr>
			  </c:forEach>
          </tbody>
</table>
</br>
</div>
<div class="tabPageUnSelected" id="hwDIV">
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="14" style="text-align:left;">New PT-HW rate Profile-15N(RMB per kilo)</th>
            </tr>
            <tr>
                <th >Country-Depot</th>
                 <c:forEach items="${ndocumentList_}" var="weightBand">
					<th>${weightBand.name}</th>
			     </c:forEach>
			     <th></th>
            </tr>
        </thead>
        <tbody id="tb1">
        	<c:forEach items="${ndocumentCountrys}" var="country" varStatus="co">
				<tr id='tb1_${co.index}' align="center">
					<td>
					${country.countryCode}
					</td>
					<c:forEach items="${ndocumentList_}" var="weightBand" begin="0">
							<c:set var="key">${business.id}_${ndocument}_${weightBand.id}_${country.id}</c:set>
						    <td>${hwRateMap[key]}</td>
				   </c:forEach>
				   <td></td>
			   </tr>
			</c:forEach>
        </tbody>
        <thead>
			<tr align="center">
                <th colspan="14" style="text-align:left;">New PT-HW rate Profile-48N(RMB per kilo)</th>
            </tr>
            <tr>
                <th >Country-Depot</th>
                 <c:forEach items="${eonomyList_}" var="weightBand">
					<th>${weightBand.name}</th>
			     </c:forEach>
            </tr>
        </thead>
        <tbody id="tb2">
        	<c:forEach items="${eonomyCountrys}" var="country" varStatus="co">
				<tr id='tb2_${co.index}' align="center">
					<td>
					${country.countryCode}
					</td>
					<c:forEach items="${eonomyList_}" var="weightBand" begin="0">
							<c:set var="key">${business.id}_${eonomy}_${weightBand.id}_${country.id}</c:set>
						    <td>${hwRateMap[key]}</td>
				   </c:forEach>
			   </tr>
			</c:forEach>
        </tbody>
</table>
</div>
</div>
<div class="tabPageUnSelected" id="recDIV">
	<div style="padding:0;" id="tabsI">
	  <ul>
	    <li><a href="#" onclick="tabControlRec(0)" title="Discount Profile" id="aa0"><span id="ss0">Discount Profile</span></a></li>
	    <li><a href="#" onclick="tabControlRec(1)" title="Heavy Weight Rate" id="aa1"><span id="ss1">Heavy Weight Rate</span></a></li>
	    <li><a href="#" onclick="tabControlRec(2)" title="Consignment Profile" id="aa2"><span id="ss2">Consignment Profile</span></a></li>
	  </ul>
	</div>
<div class="tabPageSelected" id="disDIVrec">
 <table>
 <tr>
 <td style="background-color:#F5C07B">Summary </td><td style="background-color:#EFEFEF">Rev(CNY)</td><td>${recZoneSummary.revM}/M</td>
 <td>${recZoneSummary.revY}/Y</td><td style="background-color:#EFEFEF">Cons</td><td>${recZoneSummary.consM}/M</td><td>${recZoneSummary.consY}/Y</td>
  <td style="background-color:#EFEFEF">Kilo(kg) </td><td>${recZoneSummary.kiloM}/M</td><td>${recZoneSummary.kiloY}/Y</td>
 </tr>
 </table>
<br/>
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="25" style="text-align:left;">Discounts Profile-15D/12D/10D/09D</th>
            </tr>
            <tr>
                <th rowspan="2">Weightband</th>
                <th rowspan="2">Inc</th>
                <th rowspan="2">Add On</th>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th colspan="2">${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
            <tr>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>Base</th>
						<th>Int</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${documentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<td>${weightBand.addOnWeightInt}kg</td>
					<c:if test="${weightBand.type=='base'}">
						<td align="center">N</td>
					</c:if>
					<c:if test="${weightBand.type=='add'}">
						<td align="center">Y</td>
					</c:if>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
					    <c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<c:if test="${weightBand.type=='base'}">
							<td>${recDiscountMap[key]}%</td>
						</c:if>
						<c:if test="${weightBand.type=='add'}">
							<td></td>
						</c:if>
						<td>${recDiscountMap[key]}%</td>	
				   </c:forEach>
			   </tr>
			</c:forEach>
          </tbody>
</table>
<br />
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="25" style="text-align:left;">Discounts Profile-15N/12N/10N/09N</th>
            </tr>
            <tr>
                <th rowspan="2">Weightband</th>
                <th rowspan="2">Inc</th>
                <th rowspan="2">Add On</th>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th colspan="2">${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
            <tr>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>Base</th>
						<th>Int</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${ndocumentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<td>${weightBand.addOnWeightInt}kg</td>
					<c:if test="${weightBand.type=='base'}">
						<td align="center">N</td>
					</c:if>
					<c:if test="${weightBand.type=='add'}">
						<td align="center">Y</td>
					</c:if>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
					    <c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<c:if test="${weightBand.type=='base'}">
							<td>${recDiscountMap[key]}%</td>
						</c:if>
						<c:if test="${weightBand.type=='add'}">
							<td></td>
						</c:if>
						<td>${recDiscountMap[key]}%</td>	
				   </c:forEach>
			   </tr>
			</c:forEach>
          </tbody>
</table>
<br/>
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="25" style="text-align:left;">Discounts Profile-48N</th>
            </tr>
            <tr>
                <th rowspan="2">Weightband</th>
                <th rowspan="2">Inc</th>
                <th rowspan="2">Add On</th>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th colspan="2">${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
            <tr>
               <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>Base</th>
						<th>Int</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
           <c:forEach items="${economyList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<td>${weightBand.addOnWeightInt}kg</td>
					<c:if test="${weightBand.type=='base'}">
						<td align="center">N</td>
					</c:if>
					<c:if test="${weightBand.type=='add'}">
						<td align="center">Y</td>
					</c:if>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
					    <c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<c:if test="${weightBand.type=='base'}">
							<td>${recDiscountMap[key]}%</td>
						</c:if>
						<c:if test="${weightBand.type=='add'}">
							<td></td>
						</c:if>
						<td>${recDiscountMap[key]}%</td>	
				   </c:forEach>
			   </tr>
			</c:forEach>
        </tbody>
    </table>
<br />
</div>
<div class="tabPageSelected" id="conDIVrec">
<table class="table_B" width="100%">
        <thead>
						<tr align="center">
                <th colspan="14" style="text-align:left;">Consignmengt Profile- 15D/12D/10D/09D</th>
            </tr>
            <tr>
                <th>Weightband</th>
                 <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${documentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<td>${recConsignmentMap[key]}</td>
				   </c:forEach>
			   </tr>
			</c:forEach>
          </tbody>
</table>
<br>
<table class="table_B" width="100%">
        <thead>
						<tr align="center">
                <th colspan="14" style="text-align:left;">Consignmengt Profile- 15N/12N/10N/09N</th>
            </tr>
            <tr>
                <th>Weightband</th>
                <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th>${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
           <c:forEach items="${ndocumentList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<td>${recConsignmentMap[key]}</td>
				   </c:forEach>
			   </tr>
			  </c:forEach>
          </tbody>
</table>
<br>
<table class="table_B" width="100%">
        <thead>
						<tr align="center">
                <th colspan="14" style="text-align:left;">Consignmengt Profile- 48N</th>
            </tr>
            <tr>
                <th >Weightband</th>
                <c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<th >${zoneGroup.zone}</th>
				</c:forEach>
            </tr>
        </thead>
        <tbody>
             <c:forEach items="${economyList}" var="weightBand">
				<tr>
					<td>${weightBand.name}</td>
					<c:forEach items="${zoneGroupList}" var="zoneGroup" begin="0">
						<c:set var="key">${weightBand.id}_${zoneGroup.id}</c:set>
						<td>${recConsignmentMap[key]}</td>
				   </c:forEach>
			   </tr>
			  </c:forEach>
          </tbody>
</table>
</br>
</div>
<div class="tabPageSelected" id="hwDIVrec">
<table class="table_B" width="100%">
        <thead>
			<tr align="center">
                <th colspan="14" style="text-align:left;">New PT-HW rate Profile-15N(RMB per kilo)</th>
            </tr>
            <tr>
                <th >Country-Depot</th>
                 <c:forEach items="${ndocumentList_}" var="weightBand">
					<th>${weightBand.name}</th>
			     </c:forEach>
			     <th></th>
            </tr>
        </thead>
        <tbody id="tb1">
        	<c:forEach items="${ndocumentCountrys}" var="country" varStatus="co">
				<tr id='tb1_${co.index}' align="center">
					<td>
					${country.countryCode}
					</td>
					<c:forEach items="${ndocumentList_}" var="weightBand" begin="0">
							<c:set var="key">${business.id}_${ndocument}_${weightBand.id}_${country.id}</c:set>
						    <td>${recHwRateMap[key]}</td>
				   </c:forEach>
				   <td></td>
			   </tr>
			</c:forEach>
        </tbody>
        <thead>
			<tr align="center">
                <th colspan="14" style="text-align:left;">New PT-HW rate Profile-48N(RMB per kilo)</th>
            </tr>
            <tr>
                <th >Country-Depot</th>
                 <c:forEach items="${eonomyList_}" var="weightBand">
					<th>${weightBand.name}</th>
			     </c:forEach>
            </tr>
        </thead>
        <tbody id="tb2">
        	<c:forEach items="${eonomyCountrys}" var="country" varStatus="co">
				<tr id='tb2_${co.index}' align="center">
					<td>
					${country.countryCode}
					</td>
					<c:forEach items="${eonomyList_}" var="weightBand" begin="0">
							<c:set var="key">${business.id}_${eonomy}_${weightBand.id}_${country.id}</c:set>
						    <td>${recHwRateMap[key]}</td>
				   </c:forEach>
			   </tr>
			</c:forEach>
        </tbody>
</table>
</div>
</div>
</div>
</div>
  <br />
<span style="background-color:#EEEEEE">Supporting Documents for a PT Loading Request &nbsp;</span>  <span><input type="text" id="fileName" size="25"/></span>
</div>
<br />
<br />
<div align="left">
	<input type="file" name="Browser" id="file_upload" />
	<a href="javascript:$('#file_upload').uploadify('upload','*')">upload</a>&nbsp;   
        <a href="javascript:$('#file_upload').uploadify('cancel', '*')">uploadCancel</a> 
</div>
  <div style="text-align:center">
  <input type="button" id="toBilling" value="To Billing" class="cls-button" /> 
  &nbsp;&nbsp;&nbsp;<input type="button" value="Export TariffCard" class="cls-button" onclick="downLoadTariffPdf();"/> 
  &nbsp;&nbsp;&nbsp;<input type="button" value="Return" class="cls-button" onclick="javascript:history.go(-1)" />
   </div>
   <br />
   <input type="hidden" id="hiddenID" value="${business.id}" name="business.id">
</form>
</div>
<script type="text/javascript">

    $(function() {
    	var businessId = document.getElementById("hiddenID").value;
    	$("#toBilling").click(function(){
            $.ajax({
                type:"POST",
                url:"${ctx}/ptApprove/toBilling",
                data:"id="+businessId,
                success:function(data){
                	alert('Approve success !');
                },error:function(e) {
                	alert("error："+e);
                }
            });
        });
    	
	    $("#file_upload").uploadify({
	    	'height'        : 27, 
	    	'width'         : 80,  
	    	'buttonText'    : 'browse',
	        'swf'           : '<%=path%>/uploadify/uploadify.swf',
	        'uploader'      : '${ctx}/ptApprove/uploadFile/'+businessId,
	        'auto'          : false,
	        //'fileTypeExts'  : '*.xls',
	        'formData'      : {'userName':'','qq':''},
	        'onUploadSuccess': function(file, data)
	        {		
	        	document.getElementById("fileName").innerText=file.name;
	        }
	    });
	    
	    $("#deleteFile").click(function(){
        	var fileName = document.getElementById("fileName").innerText;
            $.ajax({
                type:"POST",
                url:"${ctx}/ptApprove/deleteFile",
                data:"id="+businessId+"&fileName="+fileName,
                success:function(data){
                	alert("delete success!");
                	document.getElementById("fileName").innerText="";
                },error:function(e) {
                    alert("error："+e);
                }
            });
        });
	});
    
    function downLoadTariffPdf(){
    	var id = document.getElementById("hiddenID").value;
        document.forms[0].action="${ctx}/documentDown/downDocument/"+id;
		document.forms[0].submit();
    }
</script>
<script type="text/javascript">
    
function tabPageControl(n) {
	if(n==1){
		document.getElementById("recDIV").style.cssText = "display:block;";
		document.getElementById("sedDIV").style.cssText = "display:none;";
		document.getElementById("rp").style.cssText = "background-position:0% -42px;";
		document.getElementById("rps").style.cssText = "background-position:100% -42px;";
		document.getElementById("sp").style.cssText = "background-position:";
		document.getElementById("sps").style.cssText = "background-position:";
		for(var i=0;i<=2;i++){
			if(i==0){
				var links= "aa"+i;var sp= "ss"+i;
				document.getElementById(links).style.cssText = "background-position:0% -42px;";
				document.getElementById(sp).style.cssText = "background-position:100% -42px;";
			}else{
				var links= "aa"+i;var sp= "ss"+i;
				document.getElementById(links).style.cssText = "background-position:";
				document.getElementById(sp).style.cssText = "background-position:";
			}
		}
	}else{
		document.getElementById("sedDIV").style.cssText = "display:block;";
		document.getElementById("recDIV").style.cssText = "display:none;";
		document.getElementById("rp").style.cssText = "background-position:";
		document.getElementById("rps").style.cssText = "background-position:";
		document.getElementById("sp").style.cssText = "background-position:0% -42px;";
		document.getElementById("sps").style.cssText = "background-position:100% -42px;";
		for(var i=0;i<=2;i++){
			if(i==0){
				var links= "a"+i;var sp= "s"+i;
				document.getElementById(links).style.cssText = "background-position:0% -42px;";
				document.getElementById(sp).style.cssText = "background-position:100% -42px;";
			}else{
				var links= "a"+i;var sp= "s"+i;
				document.getElementById(links).style.cssText = "background-position:";
				document.getElementById(sp).style.cssText = "background-position:";
			}
		}
	}
	
}
function tabControl(n) {
	for(var i=0;i<=2;i++){
		if(i==n){
			var links= "a"+i;var sp= "s"+i;
			document.getElementById(links).style.cssText = "background-position:0% -42px;";
			document.getElementById(sp).style.cssText = "background-position:100% -42px;";
		}else{
			var links= "a"+i;var sp= "s"+i;
			document.getElementById(links).style.cssText = "background-position:";
			document.getElementById(sp).style.cssText = "background-position:";
		}
	}
	if(n==1){
		document.getElementById("hwDIV").style.cssText = "display:block;";
		document.getElementById("disDIV").style.cssText = "display:none;";
		document.getElementById("conDIV").style.cssText = "display:none;";
		
	}else if(n==2){
		document.getElementById("conDIV").style.cssText = "display:block;";
		document.getElementById("hwDIV").style.cssText = "display:none;";
		document.getElementById("disDIV").style.cssText = "display:none;";
	}else{
		document.getElementById("disDIV").style.cssText = "display:block;";
		document.getElementById("hwDIV").style.cssText = "display:none;";
		document.getElementById("conDIV").style.cssText = "display:none;";
	}
}

function tabControlRec(n) {
	for(var i=0;i<=2;i++){
		if(i==n){
			var links= "aa"+i;var sp= "ss"+i;
			document.getElementById(links).style.cssText = "background-position:0% -42px;";
			document.getElementById(sp).style.cssText = "background-position:100% -42px;";
		}else{
			var links= "aa"+i;var sp= "ss"+i;
			document.getElementById(links).style.cssText = "background-position:";
			document.getElementById(sp).style.cssText = "background-position:";
		}
	}
	if(n==1){
		document.getElementById("hwDIVrec").style.cssText = "display:block;";
		document.getElementById("disDIVrec").style.cssText = "display:none;";
		document.getElementById("conDIVrec").style.cssText = "display:none;";
	}else if(n==2){
		document.getElementById("conDIVrec").style.cssText = "display:block;";
		document.getElementById("hwDIVrec").style.cssText = "display:none;";
		document.getElementById("disDIVrec").style.cssText = "display:none;";
	}else{
		document.getElementById("disDIVrec").style.cssText = "display:block;";
		document.getElementById("hwDIVrec").style.cssText = "display:none;";
		document.getElementById("conDIVrec").style.cssText = "display:none;";
	}
}
</script>
</body>
</html>
