<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>

<%
	session.invalidate();
%>
<script>
	location.href = 'index.jsp';
</script>