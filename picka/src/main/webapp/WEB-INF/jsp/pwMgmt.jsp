<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>
    
<script type="text/javascript" >
var lv_IsOldPwValid = false;
var lv_IsNewPwValid = false;

	$(document).ready(function () {
	    
		$('#btnConfirm').click(function(){

			var url = "/userJoin/isUserIdPwdValid";
			$.ajax({
				type : "POST",
				url : url,
				data : {"userId":userId
					,"pw":$("#oldPw").val()},
				async : false
			}).done(function(data) {
				if (data) {
					lv_IsOldPwValid = true;
				} else {
					alert("기존 비밀번호를 다시 확인해주세요.");
					$("#oldPw").focus();
					return;
				}
			});

			if (lv_IsOldPwValid) {
				if ($('#newPw').val() == $('#newPwCheck').val()) {
					lv_IsNewPwValid = true;
				} else {
					alert("새 비밀번호를 다시 확인해주세요.");
					return;
				}
			}
			
			if ((lv_IsOldPwValid) && (lv_IsNewPwValid)) {
				// validation 통과 후 회원 정보 저장
				url = "/userJoin";
	 			$.post(url
	 				  , {"userId":userId
	 					,"pw":$('#newPw').val()
						,"requestCd":"mdpw"}
	 				  ,function(data){
	 					$('#content').html(data);
	 			},'html');
			}
		});
	});
	
</script>

<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h2 style="margin-top: 20px;">비밀번호 변경</h2>
            <hr class="star-primary">
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
            <!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
            <form name="sentMessage" id="contactForm" novalidate onsubmit="javascript:return false;">
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        <label>Old Password</label>
                        <input type="password" class="form-control" placeholder="Password" id="oldPw" required data-validation-required-message="Please enter your password.">
                        <p class="help-block text-danger"></p>
                    </div>
                </div>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        <label>New Password</label>
                        <input type="password" class="form-control" placeholder="Password" id="newPw" required data-validation-required-message="Please enter your password.">
                        <p class="help-block text-danger"></p>
                    </div>
                </div>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        <label>Re-Password</label>
                        <input type="password" class="form-control" placeholder="Re-Password" id="newPwCheck" required data-validation-required-message="Please enter your password.">
                        <p class="help-block text-danger"></p>
                    </div>
                </div>
                <br>
                <div id="success"></div>
                <div class="row">
                    <div class="form-group col-xs-12">
                        <button type="submit" class="btn btn-success btn-lg" style="width:100%;" id="btnConfirm">Confirm</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>