<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

        <div class="container" id="content">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 style="margin-top: 20px;">Log in</h2>
                    <hr class="star-primary">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
                    <!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
                    <form name="sentMessage" id="contactForm" onsubmit="javascript:return false;" novalidate>
                   		<div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>ID</label>
                                <input type="text" class="form-control" placeholder="ID" id="id">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                                <label>Password</label>
                                <input type="password" class="form-control" placeholder="Password" id="pwd" required data-validation-required-message="Please enter your password.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <br>
                        <div id="success"></div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <button type="submit" id="signIn" class="btn btn-success btn-lg" style="float:center; width:100%">Sign In</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-xs-12">
                                <button type="submit" id="newMb" class="btn btn-default btn-lg" style="float:center; width:100%">New Member</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    
    <script type="text/javascript">
    $(document).ready(function (){
    	
    	$('#newMb').click(function(){
    		var url = "/memberMgmt";
    		$.post( url
    			, {id : $("#id").val()}
    			, function(data) {
					$("#content").html(data);    			
    		} );
	    });
    	$('#signIn').click(function(){
    		var url = "/userJoin/isUserIdPwdValid";
    		$.post( url
    			, {userId : $("#id").val(), pw : $("#pwd").val()}
    			,function(data){
 					if (data) { //로그인 성공시
 						userId = $("#id").val();
 						$.post( "/home"
 								,{id :$("#id").val()}
 								,function(data) {
 									$("#content").html(data);
 								});
 					} else { // 로그인 실패시
 						alert('로그인 아이디와 패스워드를 확인해주세요');
 						$("#pwd").val("");
 						$("#pwd").focus();
 					}
    		} );
	    });
    });
    </script>

