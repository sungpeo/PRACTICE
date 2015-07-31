<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="http://code.jquery.com/jquery-2.1.1.min.js" type="text/javascript"></script>
<title>:: Admin Page ::</title>
<script type="text/javascript">
var menuCnt = 0;

	function fn_btnSave() {
		var menuName = "";
		var price = "";
		var menuSrc= "";
		for(var i = 1; i <= menuCnt; i++) {
			menuName = menuName + $('#menuName_'+i).val() + ',';
			price = price + $('#price_'+i).val() + ',';
			menuSrc = menuSrc + $('#menuSrc_'+i).val() + ',';
		}
		$('#price').val(price);
		$('#menuName').val(menuName);
		$('#menuSrc').val(menuSrc);
		document.form1.submit();
	}
	
	function fn_addMenuBtn() {
		menuCnt = menuCnt + 1;
		$('#input_menu').append("<input type='text' id='menuName_"+menuCnt+"' name='menuName_"+menuCnt+"'>/<input type='text' id='price_"+menuCnt+"' name='price_"+menuCnt+"'>/<input type='text' id='menuSrc_"+menuCnt+"' name='menuSrc_"+menuCnt+"'><br/>");
	}
	
	$(document).ready(function() {
		
		$('#majorCategory').change(function() {
			
			$('#minorCategory').html("");
			
			if ($('#majorCategory').val() == 'ko') {

				$('#minorCategory').append("<option value='ko_0'>정통 한식</option>");
				$('#minorCategory').append("<option value='ko_1'>탕, 찌개, 전골</option>");
				$('#minorCategory').append("<option value='ko_2'>국수, 면요리</option>");
				$('#minorCategory').append("<option value='ko_3'>고기 요리</option>");
				
			} else if ($('#majorCategory').val() == 'jp') {

				$('#minorCategory').append("<option value='jp_0'>정통 일식</option>");
				$('#minorCategory').append("<option value='jp_1'>회, 스시</option>");
				$('#minorCategory').append("<option value='jp_2'>라멘, 소바, 우동</option>");
				$('#minorCategory').append("<option value='jp_3'>철판 요리</option>");
				
			} else if ($('#majorCategory').val() == 'ch') {

				$('#minorCategory').append("<option value='ch_0'>정통 중식</option>");
				$('#minorCategory').append("<option value='ch_1'>딤섬, 만두</option>");
				$('#minorCategory').append("<option value='ch_2'>퓨전 중식</option>");
				$('#minorCategory').append("<option value='ch_3'>기타 중식</option>");
				
			} else if ($('#majorCategory').val() == 'ws') {

				$('#minorCategory').append("<option value='ws_0'>이태리 음식</option>");
				$('#minorCategory').append("<option value='ws_1'>스테이크, 바베큐</option>");
				$('#minorCategory').append("<option value='ws_2'>시푸드 요리</option>");
				$('#minorCategory').append("<option value='ws_3'>패밀리 레스토랑</option>");
				
			} else if ($('#majorCategory').val() == 'ac') {

				$('#minorCategory').append("<option value='ac_0'>칵테일, 와인</option>");
				$('#minorCategory').append("<option value='ac_1'>치킨, 호프, 펍</option>");
				$('#minorCategory').append("<option value='ac_2'>전통 주점, 포차</option>");
				$('#minorCategory').append("<option value='ac_3'>일반 주점</option>");
				
			}			
		});
	});
</script>
</head>
<form name="form1" method="post" action="insertStore" enctype="multipart/form-data">
	<table>
	<tr>
	<td>상호명</td>
	<td><input type="text" id="storeName" name="storeName" required/></td>
	</tr>
	<tr>
	<td colspan=2>카테고리</td>
	</tr>
	<tr>
	<td>대분류</td>
	<td><select id="majorCategory" name="majorCategory">
    	<option value="ko">한식</option>
		<option value="jp">일식</option>
	    <option value="ch">중식</option>
	    <option value="ws">양식</option>
	    <option value="ac">주점</option>
	</select>
	</td>
	</tr>
	<tr>
	<td>소분류</td>
	<td><select id="minorCategory" name="minorCategory">
		<option value='ko_0'>정통 한식</option>
		<option value='ko_1'>탕, 찌개, 전골</option>
		<option value='ko_2'>국수, 면요리</option>
		<option value='ko_3'>고기 요리</option>
	</select></td>
	</tr>
	<tr>
	<td>최대수용인원</td>
	<td><input type="text" id="capacity" name="capacity" size=2 maxlength=3 required/>명</td>
	</tr>
	<tr>
	<td>메뉴명/가격  <button id='addMenuBtn' onClick='fn_addMenuBtn()'>추가</button></td>
	<td id='input_menu'>
		<input type='hidden' id='menuName' name='menuName'/>
		<input type='hidden' id='price' name='price'/>
		<input type='hidden' id='menuSrc' name='menuSrc'/>
		<!-- menu 입력란 추가되는 부분 -->
	</td>
	</tr>
	<tr>
	<td>연락처</td>
	<td><input type="text" id="phone" name="phone" required/></td>
	</tr>
	<tr>
	<td>주소</td>
	<td><input type="text" id="addr" name="addr" required/></td>
	</tr>
	<tr>
	<td>대표이미지:url</td>
<!-- <td><input type="file" id="file" name="src" accept="image/*" /></td> -->
	<td><input type="text" id="imgUrl" name="imgUrl" required/></td>
	</tr>
	</table>
	<br/>
	<input type="button" id="btnSave" name="btnSave" value="저장" onClick="fn_btnSave()" />
	
</form>
<body>
</body>
</html>