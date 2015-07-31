<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

<html>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=3c969073ae220a90d17d2a9888d69926"></script>
    
    <script src="<%=cp%>/resources/bootstrap/js/jquery.js" type="text/javascript"></script>
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

    <!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
    <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    
    <!-- Custom CSS -->
    <link href="<%=cp%>/resources/bootstrap/css/sb-admin-2.css" rel="stylesheet">

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
		
		//전화번호 button click 이벤트
		$("#phoneCall").click(function(){
			var phoneNum = "02-424-1241"; //TODO:선택된 가게의 전화번호
			if(confirm(phoneNum+"로 연결하시겠습니까?")){
				//TODO:회원 db의 contact list에 반영
			}
		});
		
		//찜 button click 이벤트
		$("#wishBtn").click(function(){
			if( $("#wishBtn").attr("class").indexOf("default") != -1 ){ // 찜x -> 찜o
				var newClass = $("#wishBtn").attr("class").replace("default", "danger");
				$("#wishBtn").attr("class", newClass);
				alert("찜 되었습니다.");
				//TODO:회원 db의 찜 값 변경
			}else{ // 찜x -> 찜o
				var newClass = $("#wishBtn").attr("class").replace("danger", "default");
				$("#wishBtn").attr("class", newClass);
				alert("찜이 해제 되었습니다.");
				//TODO:회원 db의 찜 값 변경
			}
		});
		
		//tab1:메뉴 생성
		var menuLength = 4; //TODO:메뉴개수
		for(var i=0; i<menuLength; i++){
			var imgSrc = "http://timetree.zumst.com/2014/08/18/18/d27c945b5e394122ae5d6794801a71da.jpeg"; //TODO:이미지url
			var menuName = "삼겹살 정식"; //TODO:메뉴이름
			var menuPrice = "15000"; //TODO:메뉴가격
			
			$("#tab1").append("<div class='row' id='menurow_"+i+"'></div><hr>");
			$("#menurow_"+i).append("<br>");
			$("#menurow_"+i).append("<div style='margin-left:15px' id='menu_"+i+"'></div>");
			$("#menu_"+i).append("<img src='"+imgSrc+"' style='width:100px;height:100px' class='img-circle'>");
			$("#menu_"+i).append("<font style='margin-left:5px'>"+menuName+"</font>");
			$("#menu_"+i).append("<font style='margin-left:5px'>|</font>");
			$("#menu_"+i).append("<font style='color:blue;font-weight:bold;'>"+comma(menuPrice)+"</font>");
		}
		
// 		<div class="row">    
// 		  <br>
// 		  <div style="margin-left:15px">
// 		    <img alt="" src="http://timetree.zumst.com/2014/08/18/18/d27c945b5e394122ae5d6794801a71da.jpeg" style="width:100px;height:100px" class="img-circle">
// 		    <font style="margin-left:5px">삼겹살 정식</font>
// 		    <font style="margin-left:5px">|</font>
// 		    <font style="color:blue;font-weight:bold;">15,000원</font>
// 		  </div>
// 		</div>
// 		<hr>
		
		//tab2:정보 지도 api
		var lat = 37.5599154; //TODO:선택된 매장의 위도 경도
		var lng = 126.9211886;
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
		 
		oMarker = new nhn.api.map.Marker(oIcon, { title : '상호명' }); //TODO:상호명
		oMarker.setPoint(oMap.getCenter());
		oMap.addOverlay(oMarker);
		 
		oLabel = new nhn.api.map.MarkerLabel();
		oMap.addOverlay(oLabel);
		oLabel.setVisible(true, oMarker);     //마커 표시 설정
		
		//tab3:후기 click 이벤트
		$("#review").click(function() {
			 $( "#tab3" ).load( "review", function() {
				 //callback
			 });
		});
		
		//tab4:다음장소추천 click 이벤트
		$("#nextPlace").click(function() {
			var majorCategory = ""; //TODO:선택된 매장의 정보
			var foodLevel = 0;
			var drinksCode = 0;
			var lat = 37.5599154; 
			var lng = 126.9211886;

			$.post( "/getSecondStoreList"
					,{'majorCategory' : majorCategory,
 					  'foodLevel' : foodLevel,
 					  'drinksCode' : drinksCode,
 					  'lng' : lng,
 					  'lat' : lat
 					  }  //TODO 현재위치 하드코딩 {id :$("#id").val()}
				,function(data) { //TODO 현재위치 하드코딩
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
	
</script>

<body id="page-top" class="index">
<div class="container">
    <div class="page-header">
        <h1>상호명
        	<span class="pull-right">
        		<button type="button" id="phoneCall" class="btn btn-success btn-circle btn-lg"><span class="glyphicon glyphicon-earphone"></span></button>
                <button type="button" id="wishBtn" class="btn btn-default btn-circle btn-lg"><span class="glyphicon glyphicon-heart"></span></button>
            </span>
        </h1>
    </div>
    <div class="row">
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
											<td style="padding:5px">오후 4:00 ~ 익일 새벽 2:00</td>
										</tr>
										<tr>
											<td style="padding:5px"><strong>휴무일</strong></td>
											<td style="padding:5px">연중무휴</td>
										</tr>
										<tr>
											<td style="padding:5px"><strong>전화번호</strong></td>
											<td style="padding:5px">02-828-4242</td>
										</tr>
									</table>
								</div>
							</div>
							<!--/정보-->
						</div>
                        <div class="tab-pane fade" id="tab3">Primary 3 본문영역</div>
                        <div class="tab-pane fade" id="tab4">다음장소추천 로딩 페이지</div>
                    </div>
                </div>
            </div>
        </div>
	</div>
</div>
<br/>
</body>
</html>