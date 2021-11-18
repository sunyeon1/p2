<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객의 소리 글쓰기</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script src="../js/jquery-3.6.0.js"></script>
<script> 

      function kaja(bada){
          var somenu1=document.getElementById('somenu1')
          somenu1.style.display="none"
          
          var somenu2=document.getElementById('somenu2')
          somenu2.style.display="none"
          
          var somenu3=document.getElementById('somenu3')
          somenu3.style.display="none"
          
          var somenu3=document.getElementById('somenu4')
          somenu3.style.display="none"
         
          var somenu3=document.getElementById('somenu5')
          somenu3.style.display="none"
          
          bada.style.display="block"
          
       }
      
      $(document).ready(function() {
          $('#gul').on('keyup', function() {
              $('#gul_so').html("("+$(this).val().length+" / 500)");
   
              if($(this).val().length > 500) {
                  $(this).val($(this).val().substring(0, 500));
                  $('#gul_so').html("(500 / 500)");
              }
          });
      });
      
      
      $(document).ready(function() {
          $('#gul_1').on('keyup', function() {
              $('#gul_so_1').html("("+$(this).val().length+" / 15)");
   
              if($(this).val().length > 15) {
                  $(this).val($(this).val().substring(0, 15));
                  $('#gul_so_1').html("(15 / 15)");
              }
          });
      });

</script>
</head>
<body>
<div id = "wrap"> <!-- 헤더부분 -->
<div class="aa">
	<!-- 메뉴바 -->
	<div class="intro"> <!-- 메인에서는 몰라도 메뉴에서는 사진 사이즈나 나오는 사진이 다르게 하기위해 이름변경 -->
		
	<!-- 홈/회원가입/내정보 -->
		<ul class = "nav2">
		<%if(session.getAttribute("stv")==null){ %>
		<li><a href="../index.jsp">홈</a></li>
			<li><a href="../signup.jsp">회원가입</a></li>
			<li><a href="../login.jsp">로그인</a></li>
			<%}else{ %>
			<li><a href="../index.jsp">홈</a></li>
			<li><a href="../logout.jsp">로그아웃</a></li>
			<li><a href="../reservation/reslookup.jsp">내 예약</a></li>
			<% String id = (String) session.getAttribute("mname"); %>
			<% if(id.equals("manager")){ %>
				<li><a href="../menu/menulist.jsp">메뉴 관리하기</a></li>
				<li><a href="../reservation/reservationlist.jsp">예약 리스트</a></li>
			<%} %>
			<%} %>
		</ul>
		<!-- 홈/회원가입/내정보 - end-->
			
		
		<div class="header">
			
			<div class="title"><a href = "../index.jsp"><h1>The_Diner</h1></a></div> <!-- 타이틀 -->
			
			<div class = "nav">
				
				<ul class="list">
					<li class ="menu1" id="bigmenu1" onclick="kaja(document.getElementById('somenu1'))"><h3>The_Diner story</h3>
						<ul class="menu2" id="somenu1" style="display:none">
							<li><a href = "../story/in.jsp" >인사말</a></li>
							<li><a href = "../story/chf.jsp" >셰프소개</a></li>
							<li><a href = "../story/one.jsp" >원산지</a></li>
							<li><a href = "../story/oh.jsp" >오시는길</a></li>
						</ul>
					</li>			
					<li class ="menu1" id="bigmenu2" onclick="kaja(document.getElementById('somenu2'))"><h3>Menus</h3>
						<ul class="menu2" id="somenu2" style="display:none">
						 <li><a href = "../menu/set.jsp" >세트메뉴</a></li>
						 <li><a href = "../menu/steak.jsp" >스테이크</a></li>
						 <li><a href = "../menu/pasta.jsp" >파스타</a></li>
						 <li><a href = "../menu/salad.jsp" >샐러드</a></li>
						 <li><a href = "../menu/drink.jsp" >음료</a></li>
						</ul>
					</li>
					<li class ="menu1" id="bigmenu3" onclick="kaja(document.getElementById('somenu3'))"><h3>예약</h3>
						<ul class="menu2" id="somenu3" style="display:none">
							<li><a href = "../reservation/res.jsp" >예약 하기</a></li>
						</ul>
					</li>
					<li class ="menu1" id="bigmenu4" onclick="kaja(document.getElementById('somenu4'))"><h3>Event</h3>
						<ul class="menu2" id="somenu4" style="display:none">
							<li><a href = "../event/event.jsp" >행사안내</a></li>
						</ul>
					</li>
					<li class ="menu1" id="bigmenu5" onclick="kaja(document.getElementById('somenu5'))"><h3>고객센터</h3>
						<ul class="menu2" id="somenu5" style="display:none">
							<li><a href = "../Notice_D/Notice_D_Listform.jsp" >공지사항</a></li>
							<li><a href = "../Review_D/Review_D_Listform.jsp" >리뷰</a></li>
							<li><a href = "Question_D_Listform.jsp" >고객의 소리</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<!-- 메뉴바 - end -->	
</div>
</div>
</div> 
<!-- 헤더부분 - end -->

<!-- 중앙 -->
<div id="middle">	

	<!-- leftMenu -->
	<div class="leftMenu">
		<h2>고객센터<span>customer center</span></h2>
		<div class="lm">
			<ul class="list">
				<li class="first"><a href="../Notice_D/Notice_D_Listform.jsp"><span>공지사항</span></a></li>
				<li><a href="../Review_D/Review_D_Listform.jsp"><span>리뷰</span></a></li>
				<li class="last"><a href="Question_D_Listform.jsp"><span>고객의 소리</span></a></li>
			</ul>
		</div>
	</div>	
	<!-- leftMenu end -->
	
	<!-- mainList-->
	<div class="menuMenu">
		<!-- 메뉴이동경로 표시 -->
		<div class="menuintro">
			<h3>고객의 소리</h3>
			<ul class="road">
				<li class="home"><span>Home</span></li>
				<li><span>고객센터</span></li>
				<li class="current"><span>고객의 소리</span></li>
			</ul>
		</div>
		<!-- 메뉴이동경로 표시 - end -->
		
		<!-- 메뉴판 -->
		<div class="contents">
			<div class="pclist1">
				<% 
		//게시글 읽기에서 답변글쓰기를 클릭하면 넘겨주는 데이터들을 받아줌
		int num = Integer.parseInt(request.getParameter("num"));
		int ref = Integer.parseInt(request.getParameter("ref"));
		int res = Integer.parseInt(request.getParameter("res"));
		int rel = Integer.parseInt(request.getParameter("rel"));
	%>
		<form action = "Question_D_ReWritepro.jsp" method = "post" >
			<table	style="width: 100%">
				<tr style="height: 40px; border-bottom: 1px solid #ddd;">
						<td align = "center" width ="150">작성자</td>
						<td style="padding-left: 50px; border-left: 1px solid #ddd; align-content: center;">
							사장님
						</td>
				</tr>
				
				<tr style="height: 40px; border-bottom: 1px solid #ddd;">
						<td align = "center" width ="150">제목</td>
						<td style="padding-left: 50px; padding-right: 50px; border-left: 1px solid #ddd; align-content: center;" ><input id="gul_1" type= "text" name = "title" value = "&emsp; └[답변]"60" style="width: 100%"><div id="gul_so_1"></div></td>
				</tr>

				<tr style="height: 400px; align-content: center; border-bottom: 1px solid #ddd; ">
						<td align = "center" width ="150">글 내용</td>
						<td style="padding-left: 50px; padding-right: 50px; border-left: 1px solid #ddd; align-content: center;"><textarea id="gul" rows= "10" cols = "60" name = "content" style=" width: 100%; height: 320px; "></textarea><div id="gul_so"></div></td>
				</tr>
				
			<tr height ="40">
				<td align ="center" colspan="2">
					<input type="hidden" name ="ref" value="<%=ref%>">
					<input type="hidden" name ="res" value="<%=res%>">
					<input type="hidden" name ="rel" value="<%=rel%>">
					<input type="submit" value="작성완료">&nbsp;&nbsp;
					<input type="reset" value="초기화">&nbsp;&nbsp;
				</td>
			</tr>
			</table>		
		</form>
				<input type="button" onclick="location.href='Question_D_Listform.jsp'" value="전체글보기">
			</div>
		</div>
	</div>
</div>

<!-- footer -->
<div id="footer">
	<div class="info">
		<h1>The_Diner</h1>
		<ul class="list">
			<li class="first">주소 : 서울특별시 종로구 돈화문로 26 단성사 3층</li>
			<li>(주)The_Diner</li>
			<li>TEL : (02) 3672-9100 (내선 3번)</li>
			<li class="last">FAX : 보내지마</li>
		</ul>
		
		<ul class="list">
			<li class="first">법인명(상호명) : (주)3조</li>
			<li>대표자 : 배경은</li>
			<li class="last">사업자등록번호 : 000-00-00000</li>
		</ul>
	</div>
</div>
<!-- footer end-->
</body>
</html>