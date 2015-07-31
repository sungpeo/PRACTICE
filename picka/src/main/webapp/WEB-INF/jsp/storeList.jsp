<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>
    
<script type="text/javascript" >
$(document).ready(function () {
	$('#filter').click(function(){
		var url = "/filter";
		$.post(url
				,{'lat' : $('#latitude').val(), 'lng' : $('#logitude').val()}
			  ,function(data){
			   },'json');
	});
});

//매장 목록 출력. filter에서 storeList 가져왔을 때 사용.
function makeRowByConditions(){
 	$("#searchStoreList").append("<c:forEach var='store' items='${storeList}' varStatus='status'>");
	$("#searchStoreList").append("<div class='row' id='row_${status.count}'></div><hr>");
	$("div.row#row_${status.count}").append("<div class='col-md-7' id='md7_${status.count}'></div>");
	$("div.col-md-7#md7_${status.count}").append("<a href='#'><img class='img-responsive' src='${store.src}' alt=''></a>");
 	$("div.row#row_${status.count}").append("<div class='col-md-5' id='md5_${status.count}'></div>");
	$("div.col-md-5#md5_${status.count}").append("<h3>${store.storeName}</h3>");
	$("div.col-md-5#md5_${status.count}").append("<h4>${store.majorCategory}/${store.minorCategory}</h4>");
	$("div.col-md-5#md5_${status.count}").append("<p>${store.addr},${store.avgPoint}/5</p>");
	$("div.col-md-5#md5_${status.count}").append("<div align='right' style='margin-right:5px'><button class='btn btn-primary' onClick='fn_onclick_detail(${store.storeId})'>Detail <span class='glyphicon glyphicon-chevron-right'></span></button></div>");
	$("#searchStoreList").append("</c:forEach>");
}
	
function picka_start(){
	var gubun = '${gubun}';
	if (gubun == 'filter' || gubun == 'nextPlace' || gubun == 'contactList') {
		var storeList = '${storeList}';
		storeList = storeList.replace('[','').replace(']','');
		if (storeList) {
			$('#emptRslt').hide();
			makeRowByConditions();
		} else {
			if (gubun == 'contactList') {
				$('#emptRslt').html("<label>컨택한 업체가 없습니다.</label>");
			}
			$('#emptRslt').show();
		}
	} else { //위도경도로 검색
		var url = "/getStoreListByLatLng";
		$.post(url
				,{'lat' : $('#latitude').val(), 'lng' : $('#logitude').val()}
			  ,function(data){
				  if(data.length > 0){	//검색결과가 존재하는 경우
					$('#emptRslt').hide();
					for(var i=0; i<data.length; i++){
						makeRow(i,data);
					}
				  }else{	//검색결과가 없는 경ㅛ
					  $('#emptRslt').show();
				  }
			   },'json');
	}
}

//매장 상세정보 보기
function fn_onclick_detail (storeId) {
	var url = "/viewDetail";
	$.post(url
		,{'storeId' : storeId, 'userId':userId}
		, function (data){
			$('#content').html(data);
		}
		,'html');
}

// 필터화면 호출
function fn_onclick_filter(){
	var url = "/filter";
	$.post(url
		, null
		, function (data){
			var lat = $('#latitude').val();
			var lng = $('#logitude').val();
			$('#content').html(data);
			$("#latitude").val(lat);
			$("#logitude").val(lng);
			picka_start();
		});
}

// 매장 목록 출력
function makeRow(i,data){
	var majorCategory = data[i].majorCategory;
	var minorCategory = data[i].minorCategory;
	var src = data[i].src;
	var addr = data[i].addr;
	var avgPoint = data[i].avgPoint;
	var storeName = data[i].storeName;
	var storeId = data[i].storeId;

	$("#searchStoreList").append("<div class='row' id='row_"+i+"'></div><hr>");
	$("div.row#row_"+i).append("<div class='col-md-7' id='md7_"+i+"'></div>");
	$("div.col-md-7#md7_"+i).append("<a href='#'><img class='img-responsive' src='"+src+"' alt=''></a>");
	$("div.row#row_"+i).append("<div class='col-md-5' id='md5_"+i+"'></div>");
	$("div.col-md-5#md5_"+i).append("<h3>"+storeName+"</h3>");
	$("div.col-md-5#md5_"+i).append("<h4>"+majorCategory+"/"+minorCategory+"</h4>");
	$("div.col-md-5#md5_"+i).append("<p>"+addr+","+avgPoint+"/5</p>");
	$("div.col-md-5#md5_"+i).append("<div align='right' style='margin-right:5px'><button class='btn btn-primary' onClick='fn_onclick_detail("+storeId+")'>Detail <span class='glyphicon glyphicon-chevron-right'></span></button></div>");
}
</script>

<div hidden="true">
	<label id="latitude"></label>
	<label id="logitude"></label>
	<label id="majorCategory"></label>
	<label id="minorCategory"></label>
	<label id="minPrice"></label>
	<label id="maxPrice"></label>
	<label id="capacity"></label>
</div>

<div class="container">   
	
	<div class="row">
	    <div align="right" style="margin-right:5px" id="filter"><button class="btn btn-primary" onClick='fn_onclick_filter()'><span class="glyphicon glyphicon-filter"></span></button></div>
	    <div style="margin-top:20px"></div>
    </div>
    
    <!-- Project One -->
    <div class="row">
	    <div id="searchStoreList">
	    	<!-- row가 붙는 부분 -->
	    </div>
    </div>
    
    <div class="row">
		<div id="emptRslt" style="width: 100%; height: 300px; text-align: center; padding-top: 150px;">
			<label>검색된 내용이 없습니다.</label>
		</div>
		<div  class="list-group" id="resultList">
		</div>
	</div>
</div>
