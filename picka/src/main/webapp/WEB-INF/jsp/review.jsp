<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

<link href="<%=cp%>/resources/bootstrap/css/star-rating.css" rel="stylesheet">
<script src="<%=cp%>/resources/bootstrap/js/star-rating.js"></script>
    
<script type="text/javascript" >
var isReviewFormShown = false;

function fn_getNickName(userId) {
	var returnStr = userId;
	var url = "/userModify/getUserInfo";
	$.ajax({
		type : "POST",
		url : url,
		data : {"userId":userId},
		async : false
	}).done(function(data) {
		if (data.nickName) {
			returnStr = data.nickName;
		}
	});
	return returnStr;
}

function fn_setMyNickName(nickName) {
	if (nickName) {
		   $('#lblNickName').html("<strong>" + nickName + "</strong>");
	   } else {
		   $('#lblNickName').html("<strong>" + userId + "</strong>");
	   }	
}

function fn_loadReviewList(strId) {
	var url = "/getReviewList";
	$.post( url
			   ,{"storeId":strId}
			   ,function(data) {
				   fn_createReviewList(data);
		});
}

function fn_createReviewList(data){
	$("#divReviewList").html("");
	var review;
	for (var i = 0; i < data.length; i++) {
		review = data[i];
		
		var divNick = document.createElement('h4');
		divNick.innerHTML = "<strong>" + fn_getNickName(review.userId) + "</strong>";
		var divRatg = document.createElement('div');
		var stars = "";
		for (var j = 0; j < review.point; j++) { stars += "★"; }
		divRatg.innerHTML = "<font color='F4EC00' size='4'>" + stars + "</font>";
		var divRevw = document.createElement('div');
		divRevw.setAttribute('id', 'divRevw' + i);
		divRevw.innerText = review.review;
		
		var divRow = document.createElement('div');
		divRow.appendChild(document.createElement('hr'));
		divRow.appendChild(divNick);
		divRow.appendChild(divRatg);
		divRow.appendChild(divRevw);
		
		$("#divReviewList").append(divRow);
	}
}

$(document).ready(function () {

	$("#divReviewForm").hide();
	$("#rtgPoint").rating();
	
	$('#btnToggleReview').click(function(){
		if (isReviewFormShown) {
			$("#divReviewForm").hide();
			$("#btnToggleReview").text("후기남기기");
		} else {
			$("#divReviewForm").show();
			$("#btnToggleReview").text("취소");
		}
		isReviewFormShown = !isReviewFormShown;
	});
	
	$('#btnSaveReview').click(function(){
		var url = "/saveReview";
		$.post( url
			   ,{"storeId":$("#storeId").val(),
				 "userId":userId,
				 "review":$('#txaReview').val(),
				 "point":$('#rtgPoint').val()}
			   ,function(data) {
				   fn_createReviewList(data);
				   $('#btnToggleReview').click();
				   $('#txaReview').val("");
		});
	});
	
	fn_setMyNickName(fn_getNickName(userId));
});
</script>

<div class="container">
	<input type="hidden" id="storeId" name="storeId">
			
	<!-- 후기 작성 버튼부 시작 -->
	<div align="right">
		<button id="btnToggleReview" class="btn btn-primary" style="width:110px;">후기남기기</button>
	</div>
	<!-- 후기 작성 버튼부 종료 -->
	
	<!-- 후기 작성부 시작 -->
	<div id="divReviewForm" class="col-lg-8 col-lg-offset-2" style="margin-botton:20px; height:220px;">
		<form>
			<h4 id='lblNickName'></h4>
			<input id="rtgPoint" class="rating" data-min="0" data-max="5" data-step="1" data-size="sm">
			<textarea class="form-control animated" cols="50" id="txaReview" placeholder="Enter your review here..." rows="3"></textarea>
			<button id="btnSaveReview" class="btn btn-success" style="float:right; margin-top:10px;" type="reset">저장</button><p>
		</form>
	</div>
	<!-- 후기 작성부 종료 -->   
	<!-- 후기 목록부 시작 -->
	<div id="divReviewList" style="margin-top:20px">
	</div>
	<!-- 후기 목록부 종료 -->
</div>