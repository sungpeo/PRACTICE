<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String cp = request.getContextPath(); %> <%--ContextPath 선언 --%>

<style type="text/css">
  	#homeSearchBox {
  		margin-top: 50px;
  	}
</style>

<script type="text/javascript">
	$(document).ready(function (){
		
		$('#searchBox').focus(function(){
			fn_pageEffect();
		});
		
		$('#searchBtn').click(function(){
			fn_pageEffect();
		});
		
	});
	
	function fn_pageEffect(){
		
		$('.fadeOut').animate({opacity:0}, 500, null, function(){
			$('#homeSearchBox').animate({bottom:180}, 1000, null, function(){
				var url = "/areaSearch"
				$.post( url
	    			, function(data) {
						$("#content").html(data);    			
	    		});
			});
		});
		
	}
</script>
	
<div class="container">
	<div class="row">
        <div class="col-lg-12 text-center fadeOut">
            <h2 style="margin-top: 20px;">위치 검색</h2>
            <hr class="star-primary">
        </div>
    </div>
    <div class="row">
	  <div class="col-lg-6">
	    <div class="input-group" id="homeSearchBox">
	      <input type="text" class="form-control" placeholder="Search for..." id="searchBox">
	      <span class="input-group-btn">
	        <button class="btn btn-default" type="button" id="searchBtn">Go!</button>
	      </span>
	    </div><!-- /input-group -->
	  </div><!-- /.col-lg-6 -->
	</div><!-- /.row -->
	
	<div class="row">
		<div class="fadeOut" style="text-align: center; padding-top: 30px;">
			<img src="http://cfile10.uf.tistory.com/image/270579405297287C0865E7"/>
		</div>
	</div>
</div>

