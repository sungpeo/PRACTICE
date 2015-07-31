<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

	<style type="text/css">
	.panel.with-nav-tabs .panel-heading{
	    padding: 5px 5px 0 5px;
	}
	.panel.with-nav-tabs .nav-tabs{
		border-bottom: none;
	}
	.panel.with-nav-tabs .nav-justified{
		margin-bottom: -1px;
	}
	.nav-tabs li{
		margin-left: -3px;
		margin-right: -3px;
	}
	/********************************************************************/
	/*** PANEL PRIMARY ***/
	.with-nav-tabs.panel-primary .nav-tabs > li > a,
	.with-nav-tabs.panel-primary .nav-tabs > li > a:hover,
	.with-nav-tabs.panel-primary .nav-tabs > li > a:focus {
	    color: #fff;
	}
	.with-nav-tabs.panel-primary .nav-tabs > .open > a,
	.with-nav-tabs.panel-primary .nav-tabs > .open > a:hover,
	.with-nav-tabs.panel-primary .nav-tabs > .open > a:focus,
	.with-nav-tabs.panel-primary .nav-tabs > li > a:hover,
	.with-nav-tabs.panel-primary .nav-tabs > li > a:focus {
		color: #fff;
		background-color: #3071a9;
		border-color: transparent;
	}
	.with-nav-tabs.panel-primary .nav-tabs > li.active > a,
	.with-nav-tabs.panel-primary .nav-tabs > li.active > a:hover,
	.with-nav-tabs.panel-primary .nav-tabs > li.active > a:focus {
		color: #428bca;
		background-color: #fff;
		border-color: #428bca;
		border-bottom-color: transparent;
	}
	.with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu {
	    background-color: #428bca;
	    border-color: #3071a9;
	}
	.with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > li > a {
	    color: #fff;   
	}
	.with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > li > a:hover,
	.with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > li > a:focus {
	    background-color: #3071a9;
	}
	.with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > .active > a,
	.with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > .active > a:hover,
	.with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > .active > a:focus {
	    background-color: #4a9fe9;
	}
	
	.cus-tab{
/*  		position: absolute; */
 		height:56%;
 		top: 50px;
 		bottom: 0;
 		right: 0;
 		left: 0;
 		overflow-y:auto;
 		overflow-x:hidden;
	}
	</style>
<script type="text/javascript" >

	$(document).ready(function () {
 		$("#point").rating();
		
		//전화번호 button click 이벤트
		$("#phoneCall").click(function(){
			var phoneNum = '${store.phone}';
			if(confirm(phoneNum+"로 연결하시겠습니까?")){
				//TODO:회원 db의 contact list에 반영
				var storeId = '${store.storeId}';
				$.post( "/insertContact"
					,{'userId' : userId, 'storeId' : storeId }
					,function(data) {}
				);
			}
		});
		
		//찜 이미지 셋팅
		var wishFlag = '${wishFlag}'; //todo 찜여부
		if(wishFlag == "Y"){
			var newClass = $("#wishBtn").attr("class").replace("default", "danger");
			$("#wishBtn").attr("class", newClass);
		}else{
			var newClass = $("#wishBtn").attr("class").replace("default", "default");
			$("#wishBtn").attr("class", newClass);
		}
		
		//찜 button click 이벤트
		$("#wishBtn").click(function(){
			if( $("#wishBtn").attr("class").indexOf("default") != -1 ){ // 찜x -> 찜o
				var newClass = $("#wishBtn").attr("class").replace("default", "danger");
				$("#wishBtn").attr("class", newClass);
				alert("찜 되었습니다.");

				var storeId = '${store.storeId}';
				$.post( "/wishList/insertWish"
					,{'userId' : userId, 'storeId' : storeId }
					,function(data) {}
				);

			}else{ // 찜x -> 찜o
				var newClass = $("#wishBtn").attr("class").replace("danger", "default");
				$("#wishBtn").attr("class", newClass);
				alert("찜이 해제 되었습니다.");

				var storeId = '${store.storeId}';
				$.post( "/wishList/deleteWish"
					,{'userId' : userId, 'storeId' : storeId }
					,function(data) {}
				);

			}
		});
		
		//tab1:메뉴 생성
		fn_makeMenu();
		
		//tab2:정보 지도 api
		var lat = '${store.lat}';
		var lng = '${store.lng}';
		var oPoint = new nhn.api.map.LatLng(lat,lng);     //좌표값
		 
		//기본
		var oMap = new nhn.api.map.Map(document.getElementById('map'), { 
		point : oPoint,
		zoom : 10,
		enableWheelZoom : true,
		enableDragPan : true,
		enableDblClickZoom : false,
		mapMode : 0,
		activateTrafficMap : false,
		activateBicycleMap : false,
		minMaxLevel : [ 1, 14 ],
		size : new nhn.api.map.Size(290, 230)           
		});
		 
		//줌
		var oSlider = new nhn.api.map.ZoomControl();
		oMap.addControl(oSlider);
		oSlider.setPosition({
		top : 10,
		left : 10
		});
		 
		//지도 타입
		var oMapTypeBtn = new nhn.api.map.MapTypeBtn();
		oMap.addControl(oMapTypeBtn);
		oMapTypeBtn.setPosition({
		bottom : 10,
		right : 80
		});
		 
		 
		//마커
		var oSize = new nhn.api.map.Size(28, 37);
		var oOffset = new nhn.api.map.Size(14, 37);
		var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
		 
		oMarker = new nhn.api.map.Marker(oIcon, { title : '${store.storeName}' });
		oMarker.setPoint(oMap.getCenter());
		oMap.addOverlay(oMarker);
		 
		oLabel = new nhn.api.map.MarkerLabel();
		oMap.addOverlay(oLabel);
		oLabel.setVisible(true, oMarker);     //마커 표시 설정 
		
		// tab3 : 리뷰 클릭 이벤트
		$("#review").click(function() {
			$.post( "/review"
					,null
				,function(data) {
					$("#tab3").html(data);
					$("#storeId").val('${store.storeId}');
					fn_loadReviewList($("#storeId").val());
			});
		});
		
		//tab4:다음장소추천 click 이벤트
		$("#nextPlace").click(function() {
			var storeId = '${store.storeId}';
			var majorCategory = '${store.majorCategory}';
			var foodLevel = '${store.foodLevel}';
			var drinksCode = '${store.drinksCode}';
			var lat = '${store.lat}';
			var lng = '${store.lng}';

			$.post( "/getSecondStoreList"
					,{'storeId' : storeId,
					  'majorCategory' : majorCategory,
 					  'foodLevel' : foodLevel,
 					  'drinksCode' : drinksCode,
 					  'lng' : lng,
 					  'lat' : lat
 					  } 
				,function(data) {
					$("#tab4").html(data);
					$("#filter").hide(); //필터 숨김
					picka_start();
			});
		});
	});
	
	//콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+"원";
	}
	
	
	//메뉴만들기
	function fn_makeMenu(){
	 	$("#tab1").append("<c:forEach var='menu' items='${menuList}' varStatus='status'>");
		$("#tab1").append("<div class='row' id='menurow_${status.count}'></div><hr>");
		$("#menurow_${status.count}").append("<br>");
		$("#menurow_${status.count}").append("<div style='margin-left:15px' id='menu_${status.count}'></div>");
		$("#menu_${status.count}").append("<img src='${menu.menuSrc}' style='width:100px;height:100px' class='img-circle'>");
		$("#menu_${status.count}").append("<font style='margin-left:5px'>${menu.menuName}</font>");
		$("#menu_${status.count}").append("<font style='margin-left:5px'>|</font>");
		$("#menu_${status.count}").append("<font style='color:blue;font-weight:bold;'>"+comma('${menu.price}')+"</font>");
		$("#tab1").append("</c:forEach>");
	}
	
</script>


<div class="container">
    <div class="page-header">
        <h1>${store.storeName}</h1>
		<span class="pull-left">
			<input id="point" class="rating" data-min="0" data-max="5" data-step="0.1" data-size="sm" data-readonly='true' value='${store.avgPoint}'>
		</span>        
       	<span class="pull-right">
       		<button type="button" id="phoneCall" class="btn btn-success btn-circle btn-lg"><span class="glyphicon glyphicon-earphone"></span></button>
               <button type="button" id="wishBtn" class="btn btn-default btn-circle btn-lg"><span class="glyphicon glyphicon-heart"></span></button>
           </span>
    </div>
    <div class="row" style="margin-top:50px">
        <div class="col-md-6">
            <div class="panel with-nav-tabs panel-primary">
                <div class="panel-heading">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab1" data-toggle="tab">메뉴</a></li>
                            <li><a href="#tab2" data-toggle="tab">정보</a></li>
                            <li><a href="#tab3" data-toggle="tab" id="review">후기</a></li>
                            <li><a href="#tab4" data-toggle="tab" id="nextPlace">다음장소추천</a></li>
                        </ul>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div class="cus-tab tab-pane fade in active" id="tab1">
                        	<!--메뉴-->
                        </div>
                        <div class="tab-pane fade" id="tab2">
							<!--정보-->
							<div class="row">
								<div class="col-lg-4">
									<h3><strong>위치정보</strong></h3>
									<div id="map" style="border:1px solid #000; width:300px; height:230px;"></div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-4">
									<h3><strong>영업정보</strong></h3>
									<table>
										<tr>
											<td style="padding:5px"><strong>영업시간</strong></td>
											<td style="padding:5px">${store.bizStHour} ~ ${store.bizClsHour}</td>
										</tr>
										<tr>
											<td style="padding:5px"><strong>휴무일</strong></td>
											<td style="padding:5px">${store.offDay}</td>
										</tr>
										<tr>
											<td style="padding:5px"><strong>전화번호</strong></td>
											<td style="padding:5px">${store.phone}</td>
										</tr>
									</table>
								</div>
							</div>
							<!--/정보-->
						</div>
                        <div class="cus-tab tab-pane fade" id="tab3">Primary 3 본문영역</div>
                        <div class="cus-tab tab-pane fade" id="tab4">다음장소추천 로딩 페이지</div>
                    </div>
                </div>
            </div>
        </div>
	</div>
</div>
<br/>
