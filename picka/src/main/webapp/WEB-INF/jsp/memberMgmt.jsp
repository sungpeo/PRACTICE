<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

<style type="text/css">
	input {
		float: left;
		width: 50%;
	}
	.btn {
		padding: 3px 3px;
		float: left;
	}
	#btnConfirm {
		padding: 7px;
	}
	#confirmBtnDiv {
		margin-bottom: 0px;
	}
	label {
		width: 50%
	}
</style>
    
<script type="text/javascript" >
var lv_IsUserIdChecked = false;
var lv_IsNickNameChecked = false;
var lv_IsPasswordChecked = false;
var lv_requestCd = "join";

	$(document).ready(function () {
	    
		if (userId != "") { // 회원정보 수정 시
			var url = "/userModify/getUserInfo";
			$.post( url
				   ,{"userId":userId}
				   ,function(data) {
					   $('#userId').val(data.userId);
					   $('#nickName').val(data.nickName);
					   $('#phone').val(data.phone);
			});
		
			lv_IsUserIdChecked = true;
			lv_IsNickNameChecked = true;
			lv_requestCd = "mdif";
			
			$('#userId').attr('readonly', true);
			$('#btnIsUserIdValid').hide();
			$('#divRePw').hide();
			$('#formTitle').text("회원정보수정");
		}

		$('#btnConfirm').click(function(){
			// 비밀번호 확인부
			if (userId){ // 회원 정보 수정일 경우 입력한 비번 맞는지 확인 후 수정된 정보 저장
				var url = "/userJoin/isUserIdPwdValid";
				$.ajax({
					type : "POST",
					url : url,
					data : {"userId":userId
						,"pw":$("#pw").val()},
					async : false
				}).done(function(data) {
					if (data) {
						   lv_IsPasswordChecked = true;
					   } else {
						   $("#pw").focus();
					   }
				});
			} else { // 회원 가입일 경우 비밀번호 유효성 체크
				if ($('#pw').val() == $('#pwCheck').val()) { lv_IsPasswordChecked = true; }
			}
			
			if (!lv_IsUserIdChecked) {
				alert("id validation");
				$('#userId').focus();
				return;
			}
			
			if (!lv_IsNickNameChecked) {
				alert("nick validation");
				$('#nickName').focus();
				return;
			}
			
			if (!lv_IsPasswordChecked) {
				alert("비밀번호를 다시 확인해주세요.");
				$('#pw').focus();
				return;
			}
			
			if ((lv_IsUserIdChecked) && (lv_IsNickNameChecked) && (lv_IsPasswordChecked)) {
				// validation 통과 후 회원 정보 저장
				var url = "/userJoin";
	 			$.post(url
	 				  , {"userId":$('#userId').val()
	 					,"pw":$('#pw').val()
	 					,"nickName":$('#nickName').val()
	 					,"phone":$('#phone').val()
	 					,"requestCd":lv_requestCd}
	 				  ,function(data){
	 					$('#content').html(data);
	 			},'html');
			}
		});
		
		$('#btnIsUserIdValid').click(function() {
			if ($('#userId').val()) {
				var url = "/userJoin/isUserIdValid";
	 			$.post(url
	 				  , {"userId":$('#userId').val()}
	 				  ,function(data){
	 					if (data) { // 사용 가능한 아이디
	 						lv_IsUserIdChecked = true;
	 						alert('사용 가능한 아이디입니다.');
	 					} else { // 사용 불가한 아이디
	 						alert('중복된 아이디입니다.');	
	 					}
	 			});
			} else {
				alert("아이디를 입력해주세요.");
				$('#userId').focus();
			}
		});
		
		$('#userId').change(function() {
			lv_IsUserIdChecked = false;
		});
		
		$('#btnIsNickNameValid').click(function() {
			if ($('#nickName').val()) {
				var url = "/userJoin/isNickNameValid";
	 			$.post(url
	 				  , {"nickName":$('#nickName').val()}
	 				  ,function(data){
	 					if (data) { // 사용 가능한 닉네임
	 						lv_IsNickNameChecked = true;
	 						alert('사용 가능한 닉네임입니다.');
	 					} else { // 사용 불가한 닉네임
	 						alert('중복된 닉네임입니다.');	
	 					}
	 			});
			} else {
				alert('닉네임을 입력해주세요.');
				$('#nickName').focus();
			}
		});
		
		$('#nickName').change(function() {
			lv_IsNickNameChecked = false;
		});
	});
	
</script>

<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h2 style="margin-top: 20px;" id="formTitle">Sign in</h2>
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
                        <label>ID</label>
                        <input type="text" class="" placeholder="ID" id="userId" required data-validation-required-message="Please enter your ID.">
                        <p class="help-block text-danger" style="display:inline-block !important;"></p>
                
                        <button type="submit" class="btn btn-primary" style="float:right; width:130" id="btnIsUserIdValid">Check Id</button>
                    </div>
                </div>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        <label>Password</label>
                        <input type="password" class="form-control" placeholder="Password" id="pw" required data-validation-required-message="Please enter your password.">
                        <p class="help-block text-danger"></p>
                    </div>
                </div>
                <div class="row control-group">
                    <div id="divRePw" class="form-group col-xs-12 floating-label-form-group controls">
                        <label>Re-Password</label>
                        <input type="password" class="form-control" placeholder="Re-Password" id="pwCheck" required data-validation-required-message="Please enter your password.">
                        <p class="help-block text-danger"></p>
                    </div>
                </div>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        <label>Nickname</label>
                        <input type="text" class="" placeholder="Nickname" id="nickName" required data-validation-required-message="Please enter your nickname.">
                        <p class="help-block text-danger" style="display:inline-block !important;"></p>
                        <button type="submit" class="btn btn-primary" style="float:right; width:130" id="btnIsNickNameValid">Check Nickname</button>
                        
                    </div>
                </div>
                <div class="row control-group">
                    <div class="form-group col-xs-12 floating-label-form-group controls">
                        <label>Phone Number</label>
                        <input type="tel" class="form-control" placeholder="Phone Number" id="phone">
                        <p class="help-block text-danger"></p>
                    </div>
                </div>
                <br>
                <div id="success"></div>
                <div class="row">
                    <div class="form-group col-xs-12" id="confirmBtnDiv">
                        <button class="btn btn-success btn-lg" style="width:100%;" id="btnConfirm">Confirm</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>