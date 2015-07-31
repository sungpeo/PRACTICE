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

				$('#minorCategory').append("<option value='ko_0'>���� �ѽ�</option>");
				$('#minorCategory').append("<option value='ko_1'>��, �, ����</option>");
				$('#minorCategory').append("<option value='ko_2'>����, ��丮</option>");
				$('#minorCategory').append("<option value='ko_3'>��� �丮</option>");
				
			} else if ($('#majorCategory').val() == 'jp') {

				$('#minorCategory').append("<option value='jp_0'>���� �Ͻ�</option>");
				$('#minorCategory').append("<option value='jp_1'>ȸ, ����</option>");
				$('#minorCategory').append("<option value='jp_2'>���, �ҹ�, �쵿</option>");
				$('#minorCategory').append("<option value='jp_3'>ö�� �丮</option>");
				
			} else if ($('#majorCategory').val() == 'ch') {

				$('#minorCategory').append("<option value='ch_0'>���� �߽�</option>");
				$('#minorCategory').append("<option value='ch_1'>����, ����</option>");
				$('#minorCategory').append("<option value='ch_2'>ǻ�� �߽�</option>");
				$('#minorCategory').append("<option value='ch_3'>��Ÿ �߽�</option>");
				
			} else if ($('#majorCategory').val() == 'ws') {

				$('#minorCategory').append("<option value='ws_0'>���¸� ����</option>");
				$('#minorCategory').append("<option value='ws_1'>������ũ, �ٺ�ť</option>");
				$('#minorCategory').append("<option value='ws_2'>��Ǫ�� �丮</option>");
				$('#minorCategory').append("<option value='ws_3'>�йи� �������</option>");
				
			} else if ($('#majorCategory').val() == 'ac') {

				$('#minorCategory').append("<option value='ac_0'>Ĭ����, ����</option>");
				$('#minorCategory').append("<option value='ac_1'>ġŲ, ȣ��, ��</option>");
				$('#minorCategory').append("<option value='ac_2'>���� ����, ����</option>");
				$('#minorCategory').append("<option value='ac_3'>�Ϲ� ����</option>");
				
			}			
		});
	});
</script>
</head>
<form name="form1" method="post" action="insertStore" enctype="multipart/form-data">
	<table>
	<tr>
	<td>��ȣ��</td>
	<td><input type="text" id="storeName" name="storeName" required/></td>
	</tr>
	<tr>
	<td colspan=2>ī�װ�</td>
	</tr>
	<tr>
	<td>��з�</td>
	<td><select id="majorCategory" name="majorCategory">
    	<option value="ko">�ѽ�</option>
		<option value="jp">�Ͻ�</option>
	    <option value="ch">�߽�</option>
	    <option value="ws">���</option>
	    <option value="ac">����</option>
	</select>
	</td>
	</tr>
	<tr>
	<td>�Һз�</td>
	<td><select id="minorCategory" name="minorCategory">
		<option value='ko_0'>���� �ѽ�</option>
		<option value='ko_1'>��, �, ����</option>
		<option value='ko_2'>����, ��丮</option>
		<option value='ko_3'>��� �丮</option>
	</select></td>
	</tr>
	<tr>
	<td>�ִ�����ο�</td>
	<td><input type="text" id="capacity" name="capacity" size=2 maxlength=3 required/>��</td>
	</tr>
	<tr>
	<td>�޴���/����  <button id='addMenuBtn' onClick='fn_addMenuBtn()'>�߰�</button></td>
	<td id='input_menu'>
		<input type='hidden' id='menuName' name='menuName'/>
		<input type='hidden' id='price' name='price'/>
		<input type='hidden' id='menuSrc' name='menuSrc'/>
		<!-- menu �Է¶� �߰��Ǵ� �κ� -->
	</td>
	</tr>
	<tr>
	<td>����ó</td>
	<td><input type="text" id="phone" name="phone" required/></td>
	</tr>
	<tr>
	<td>�ּ�</td>
	<td><input type="text" id="addr" name="addr" required/></td>
	</tr>
	<tr>
	<td>��ǥ�̹���:url</td>
<!-- <td><input type="file" id="file" name="src" accept="image/*" /></td> -->
	<td><input type="text" id="imgUrl" name="imgUrl" required/></td>
	</tr>
	</table>
	<br/>
	<input type="button" id="btnSave" name="btnSave" value="����" onClick="fn_btnSave()" />
	
</form>
<body>
</body>
</html>