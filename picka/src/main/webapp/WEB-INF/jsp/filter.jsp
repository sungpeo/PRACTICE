<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

<script type="text/javascript" >
	$(document).ready(function () {
		
		$('#btnSearch').click(function(){

			var majorCategory = $('#majorCategory').val();
			var minorCategory = $('#minorCategory').val();
			var capacity = $('#capacity').val();
			var pricArr = $('#price').val().split(',');
			var lat = $('#latitude').val();
			var lng = $('#logitude').val();
			
			var url = "/getStoreListByConditions";
			$.post( url
					,{'majorCategory' : majorCategory,
					  'minorCategory' : minorCategory,
					  'capacity' : capacity,
					  'minPrice' : pricArr[0],
					  'maxPrice' : pricArr[1],
					  'latitude' : lat,
					  'logitude' : lng
					  }
					,function(data) { //TODO 현재위치 하드코딩	
						$("#content").html(data);
						/* $.post( "/storeList"
							,{'gubun' : "Y"}
							,function(data) {
								$("#content").html(data);
							}) */
							picka_start();
						}
					,'html');
		});
		
		$('#majorCategory').change(function() {
			
			$('#minorCategory').html("");
			
			if ($('#majorCategory').val() == 'ko') {

				$('#minorCategory').append("<option value=''>전체</option>");
				$('#minorCategory').append("<option value='ko_0'>정통 한식</option>");
				$('#minorCategory').append("<option value='ko_1'>탕, 찌개, 전골</option>");
				$('#minorCategory').append("<option value='ko_2'>국수, 면요리</option>");
				$('#minorCategory').append("<option value='ko_3'>고기 요리</option>");
				
			} else if ($('#majorCategory').val() == 'jp') {

				$('#minorCategory').append("<option value=''>전체</option>");
				$('#minorCategory').append("<option value='jp_0'>정통 일식</option>");
				$('#minorCategory').append("<option value='jp_1'>회, 스시</option>");
				$('#minorCategory').append("<option value='jp_2'>라멘, 소바, 우동</option>");
				$('#minorCategory').append("<option value='jp_3'>철판 요리</option>");
				
			} else if ($('#majorCategory').val() == 'ch') {

				$('#minorCategory').append("<option value=''>전체</option>");
				$('#minorCategory').append("<option value='ch_0'>정통 중식</option>");
				$('#minorCategory').append("<option value='ch_1'>딤섬, 만두</option>");
				$('#minorCategory').append("<option value='ch_2'>퓨전 중식</option>");
				$('#minorCategory').append("<option value='ch_3'>기타 중식</option>");
				
			} else if ($('#majorCategory').val() == 'ws') {

				$('#minorCategory').append("<option value=''>전체</option>");
				$('#minorCategory').append("<option value='ws_0'>이태리 음식</option>");
				$('#minorCategory').append("<option value='ws_1'>스테이크, 바베큐</option>");
				$('#minorCategory').append("<option value='ws_2'>시푸드 요리</option>");
				$('#minorCategory').append("<option value='ws_3'>패밀리 레스토랑</option>");
				
			} else if ($('#majorCategory').val() == 'ac') {

				$('#minorCategory').append("<option value=''>전체</option>");
				$('#minorCategory').append("<option value='ac_0'>칵테일, 와인</option>");
				$('#minorCategory').append("<option value='ac_1'>치킨, 호프, 펍</option>");
				$('#minorCategory').append("<option value='ac_2'>전통 주점, 포차</option>");
				$('#minorCategory').append("<option value='ac_3'>일반 주점</option>");
				
			} else {

				$('#minorCategory').append("<option value=''>전체</option>");
				
			}
			
		});
	});
	
	function picka_start(){
		$('#capacity').slider({});
		$('#price').slider({});
	}
	
</script>

<div hidden="true">
	<label id="latitude"></label>
	<label id="logitude"></label>
</div>
<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h2 style="margin-top: 20px;">상세 검색</h2>
            <hr class="star-primary">
        </div>
    </div>

    <form name="searchForm" onsubmit="javascript:return false;">
    	<div class="row" style="margin-left: 15px; margin-right: 15px; margin-top: 30px;">
	    	<div class="col-lg-8 col-lg-offset-2">
	            <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
	            <!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
	            <div class="row control-group">
	                <div>
	                    <label>메뉴 대분류</label>
	                    <select class="form-control" id="majorCategory" name="majorCategory" style="margin-top:5px;">
	                    	<option value="">전체</option>
					    	<option value="ko">한식</option>
							<option value="jp">일식</option>
						    <option value="ch">중식</option>
						    <option value="ws">양식</option>
						    <option value="ac">주점</option>
				    	</select>
	                </div>
	            </div>
	            <p>
	            <div class="row control-group" style="margin-top:20px;">
	                <div>
	                    <label>메뉴 소분류</label>
	                    <select class="form-control" id="minorCategory" name="minorCategory" style="margin-top:5px;">
	                    	<option>전체</option>
						</select>
	                </div>
	            </div>
	            <p>
	            <div class="row control-group" style="margin-top:20px;">
	                <div>
	                    <label>인원수</label>
	                    <div style="margin-top:5px;">
		                    <b>5명　　</b>
		                    <input style="width:100%;" id="capacity" name="capacity" type="text" class="span2" value="" data-slider-min="5" data-slider-max="100" data-slider-step="1" data-slider-value="15"/>
		                    <b>　　100명</b>
		                </div>
	                </div>
	            </div>
	            <p>
	            <div class="row control-group" style="margin-top:20px;">
	                <div>
	                    <label>가격대</label>
	                    <div style="margin-top:5px;">
		                    <b>30,000원　　</b>
		                    <input id="price" name="price" type="text" class="span2" value="" data-slider-min="30000" data-slider-max="200000" data-slider-step="1000" data-slider-value="[30000,200000]" style="width:100%;"/>
		                    <b>　　200,000원</b>
	                    </div>
	                </div>
	            </div>
	            <br>
	        </div>
	    </div>
	    <div class="row">
	    	<div class="col-lg-8 col-lg-offset-2" style="margin-left: 15px; margin-right: 15px;">
               <div class="row control-group" style="margin-top: 30px;">
                   <button type="submit" class="btn btn-success btn-lg" style="width:100%;" id="btnSearch">Search</button>
               </div>
	    	</div>
	    </div>
    </form>
</div>