<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="meminfoVO.Question_VO"%>
<%@page import="meminfoDAO.Question_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!--데이터를 한번에 받아오는 빈클래스를 사용하도록  -->
	<jsp:useBean id = "Question_VO" class= "meminfoVO.Question_VO">
		<jsp:setProperty name="Question_VO" property = "*" />
	</jsp:useBean>
	
	<% request.setCharacterEncoding("UTF-8"); //한글처리
	
		//Insert
		Question_DAO ndao = new Question_DAO();
		Question_VO vo = new Question_VO();
		
		String id = (String) session.getAttribute("mname");
		String title = request.getParameter("title");
		String title1 = new String(title.getBytes("ISO-8859-1"), "UTF-8");
		String content = request.getParameter("content");
		String content1 = new String(content.getBytes("ISO-8859-1"), "UTF-8");
	
		vo.setId(id);
		vo.setTitle(title1);
		vo.setContent3(content1);
	
		ndao.lnsert_Question_D(vo);
		
		response.sendRedirect("Question_D_Listform.jsp"); 
	
	%>
	
</body>
</html>