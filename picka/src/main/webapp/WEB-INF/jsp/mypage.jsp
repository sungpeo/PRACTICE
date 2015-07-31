<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>
    
<script type="text/javascript" >
function fn_loadMyNickName() {
	var url = "/userModify/getUserInfo";
	$.post( url
		   ,{"userId":userId}
		   ,function(data) {
			   if (data.nickName) {
				   $('#welcomeText').text(data.nickName + " 회원님!");
			   } else {
				   $('#welcomeText').text(userId + " 회원님!");
			   }
	});	
}

	$(document).ready(function () {
		
		fn_loadMyNickName();
			
		$('#btnModifyMyInfo').click(function() {
			var url = "/userModify";
			$.post( url
				   ,null
				   ,function(data) {
						$("#content").html(data);
			});
		});
		
		$('#btnModifyPw').click(function() {
			var url = "/changePw";
			$.post( url
				   ,null
				   ,function(data) {
						$("#content").html(data);
			});
		});
		
		$('#btnCtctList').click(function() {
			var url = "/getContactList";
			$.post( url
					,{'userId' : userId}
				   ,function(data) {
						$("#content").html(data);
						picka_start();
						$('#filter').hide();
			},'html');
		});
		
	});
	
</script>

<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h2 style="margin-top: 20px;">My Page</h2>
            <hr class="star-primary">
            <h3 id='welcomeText' style="margin-top: 50px;">신잉어 회원님!</h3>
        </div>
    </div>
    <div class="row" style="margin-left: 15px; margin-right: 15px;">
    	<div class="col-lg-8 col-lg-offset-2">
            <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
            <!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
            <div class="row control-group" style="margin-top: 30px;">
                <button type="submit" class="btn btn-info btn-lg" style="width:100%;" id="btnCtctList">컨택한 업체 리스트</button>
            </div>
            <p>
            <div class="row control-group" style="margin-top: 15px;">
                <button type="submit" class="btn btn-success btn-lg" style="width:100%;" id="btnModifyMyInfo">나의 정보 수정</button>
            </div>
            <p>
            <div class="row control-group" style="margin-top: 15px;">
                <button type="submit" class="btn btn-default btn-lg" style="width:100%;" id="btnModifyPw">비밀번호 변경</button>
            </div>
        </div>
    </div>
</div>