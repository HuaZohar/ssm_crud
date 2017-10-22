<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Ա���б�</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>TEST</h1>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">����</button>
				<button class="btn btn-danger">ɾ��</button>
			</div>
		</div>
		
		<div class="row">
			<div class="col=md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>department</th>
						<th>����</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="M"?"��":"Ů" }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary btn-xs">
									<span class="glyphicon glyphicon-pencil"></span>
									�༭
								</button>
								<button class="btn btn-danger btn-xs">
									<span class="glyphicon glyphicon-trash"></span>							
									ɾ��
								</button>
							</td>
						</tr>
					</c:forEach>
					
					
					
				</table>
			</div>
		</div>
		
		
		<div class="row">
			<div class="col-md-6">
				��ǰ ${pageInfo.pageNum }ҳ����${pageInfo.pages }ҳ����${pageInfo.total }����¼
			</div>
			
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH }/emps?pn=1">��ҳ</a></li>
				  	
				  	<c:if test="${pageInfo.hasPreviousPage }">
						<li>
							<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
							   <span aria-hidden="true">&laquo;</span>
							 </a>
						</li>
				  	</c:if>
				  					    
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
				    	<c:if test="${page_Num == pageInfo.pageNum }">
				    		<li class="active"><a href="#">${page_Num }</a></li>
				    	</c:if>
				    	<c:if test="${page_Num != pageInfo.pageNum }">
				    		<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
				    	</c:if>
				    </c:forEach>
				    
				    <c:if test="${pageInfo.hasNextPage }">
					    <li>
					      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				    </c:if>

				    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">ĩҳ</a></li>
				  </ul>
				</nav>
			</div>
			
		</div>
		
	</div>
	
<script src="${APP_PATH }/static/js/1.12.4/jquery.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/bootstrap.min.js"></script>
</body>
</html>