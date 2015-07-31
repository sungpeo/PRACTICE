<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

<html>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>A team Project</title>
    
    <!-- jQuery -->
    <script src="<%=cp%>/resources/bootstrap/js/jquery.js" type="text/javascript"></script>

    <!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
    <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<%=cp%>/resources/bootstrap/css/freelancer.css" rel="stylesheet">
    <link href="<%=cp%>/resources/bootstrap/css/slider.css" rel="stylesheet">
    <link href="<%=cp%>/resources/bootstrap/css/star-rating.css" rel="stylesheet">
    <link href="<%=cp%>/resources/bootstrap/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<%=cp%>/resources/bootstrap/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

	<style type="text/css">
		input:focus {
			outline:none;
		}
		#contact {
			padding-bottom: 0px;
		}
	</style>
    
<script type="text/javascript" >
	
	function fn_setUserId() {
		if (userId) {
			return userId;
		} else {
			return "";
		}
	}
	
	function loadHomePage(){
		var url = "";
		if(userId == ""){
			var url = "/loginForm";
		}else{
			var url = "/home";
		}
		$.post(url
			,function(data){
				$('#content').html(data);
			}
			,'html'
		);
	}
	
	//전역변수 선언부
	var userId = fn_setUserId();
	var gv_url = "";
	
	$(document).ready(function () {
	    
		//첫번째 페이지로 로그인 페이지를 로드
		loadHomePage();
		
		//막내야 힘내 버튼 클릭 시 home 페이지로 이동
		$('#homeBtn').click(function(){
			loadHomePage();
		});
		
		
		/* 메뉴 선택 이벤트 */
		//Search 메뉴 선택시
		$('#menu_search').click(function(){
			var url = "/home";
			menuSelection(url);
		});
		$('#menu_wish').click(function(){
			var url = "/wishList/getList";
			if(userId == ""){
				alert("로그인을 먼저 해주시기 바랍니다.");
				return;
			}else{
				$.post(url	//MyPage 페이지 생기면 수정필요
						,{'userId' : userId}
						,function(data){
						$('#content').html(data);
						$("#filter").hide(); //필터 숨김
						picka_start();
						if( $('#searchStoreList').children('.row').size() <= 0 ){
							$('#emptRslt').show();
							$('#emptRslt').children('label').text("찜 목록이 없습니다.");
						}
				},'html');
			}
		});
		
		//My Page 메뉴 선택시
		$('#menu_mypage').click(function(){
			var url = "/mypage";
			menuSelection(url);
		});
		
		function menuSelection(url){
			if(userId == ""){
				alert("로그인을 먼저 해주시기 바랍니다.");
				return;
			}else{
				$.post(url	//MyPage 페이지 생기면 수정필요
						,function(data){
						$('#content').html(data);
				},'html');
			}
		}
		
	});
	
</script>
	
</head>



<body id="page-top" class="index">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#page-top" id="homeBtn">막내야 힘내!</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li class="page-scroll" id="menu_search">
                        <a href="#page-top">Search</a>
                    </li>
                    <li class="page-scroll" id="menu_wish">
                        <a href="#page-top">Wish List</a>
                    </li>
                    <li class="page-scroll" id="menu_mypage">
                        <a href="#page-top">My Page</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>


    <!-- Contact Section -->
    <section id="contact">
        <div id="content">
        
        </div>
    </section>

<!--     Footer -->
<!--     <footer class="text-center"> -->
<!--         <div class="footer-below"> -->
<!--             <div class="container"> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-lg-12"> -->
<!--                         Copyright &copy; Your Website 2015 -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </footer> -->



    <!-- Bootstrap Core JavaScript -->
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
    
	<!-- Slider -->
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap-slider.js"></script>
    
    <!-- Rating -->
    <script src="<%=cp%>/resources/bootstrap/js/star-rating.js"></script>

	<!-- Plugin JavaScript -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="<%=cp%>/resources/bootstrap/js/classie.js"></script>
    <script src="<%=cp%>/resources/bootstrap/js/cbpAnimatedHeader.js"></script>

	<!-- Contact Form JavaScript -->
    <script src="<%=cp%>/resources/bootstrap/js/jqBootstrapValidation.js"></script>
    <script src="<%=cp%>/resources/bootstrap/js/contact_me.js"></script>

	<!-- Custom Theme JavaScript -->
    <script src="<%=cp%>/resources/bootstrap/js/freelancer.js"></script>
    
    <!-- Naver Map -->
    <script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=3c969073ae220a90d17d2a9888d69926"></script>

</body>

</html>
