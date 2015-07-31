<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

<script type="text/javascript" >
	var arrAdrAndXy = {};

	//start 함수
	$(document).ready(function(){
		
		$('#autocomplete').keyup(fn_onChangeAutoComplete)
		
		$('#autocompleteBtn').click(fn_onChangeAutoComplete)
		
		$('#presentLocation').click(function(){
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(successCallback);
			} else {
				alert("Geolocation is not supported by this browser.");
			}
		});
		
	});
	

	function fn_onChangeAutoComplete() {
		var area = ''+$('#autocomplete').val();
		var url = "/areaSearch/getList";
		$.post(
			url
		  	,{'area':area}
			,function(data){
				$("#resultList").empty();
				var returnLegnth = data.length;
				arrAdrAndXy = $.map(data, function(el) { return el; });
				
				if(arrAdrAndXy.length > 0){	//검색결과가 잇는 경우
					
					$('#emptRslt').hide();
					
					for(var index=0; index<arrAdrAndXy.length; index += 3){
						var area = arrAdrAndXy[index];
						
						$("#resultList").append( 
								'<a href="#" class="list-group-item" id="adrLabel ' 
								+index
								+'"'
								+' onClick="fn_onClickLabel('
								+index
								+')" ><span class="glyphicon glyphicon-chevron-down" aria-hidden="true" style="margin-right: 7px;"></span>'
								+area
								+'</a>');
					}
				}else{ //검색결과가 없는 경우
					$('#emptRslt').show();
				}
			}
			,'json'
		);
	};
	
	
	function fn_onClickLabel(index){
		var logitude = arrAdrAndXy[++index];
		var latitude = arrAdrAndXy[++index];
		goToStoreList(latitude, logitude);
	}
	
	function goToStoreList(latitude, logitude){
// 		alert('check data='+latitude+', '+logitude);
		$.post( "/storeList"
			,null  //TODO 현재위치 하드코딩 {id :$("#id").val()}
			,function(data) { //TODO 현재위치 하드코딩
				$("#content").html(data);
				$("#latitude").val(latitude);
				$("#logitude").val(logitude);
				picka_start();
		});
	}
	
	function successCallback(position) {
		var latitude = position.coords.latitude;
		var logitude = position.coords.longitude;
		goToStoreList(latitude, logitude);
	}
	
</script>

<div class="container">

	<div class="row">
	  <div class="col-lg-6">
	    <div class="input-group" id="homeSearchBox">
	      <input type="text" class="form-control" placeholder="Search for..." id="autocomplete"  placeholder="지역을 입력하세요.">
	      <span class="input-group-btn">
	        <button class="btn btn-default" type="button" id="autocompleteBtn">Go!</button>
	      </span>
	    </div><!-- /input-group -->
	  </div><!-- /.col-lg-6 -->
	</div><!-- /.row -->
	
	<div class="row">
		<div class="col-lg-6" style="margin-top: 5px; margin-bottom: 15px;">
			<div id="presentLocation">
				<a href="#" style="text-decoration: none">>> 현재위치로 매장 바로 검색</a>
			</div>
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
