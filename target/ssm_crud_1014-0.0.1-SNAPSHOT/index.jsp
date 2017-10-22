<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>

	<!--员工修改的模态框-->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      <div class="modal-body">
	      
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" checked id="gender1_update_input" value="M"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
					<select class="form-control" name="dId">
					</select>
			    </div>
			  </div>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>



	<!--员工添加的模态框-->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	      
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" checked id="gender1_add_input" value="M"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
					<select class="form-control" name="dId">
					</select>
			    </div>
			  </div>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>TEST</h1>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		
		<div class="row">
			<div class="col=md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>department</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-6" id="page_info_area">
				
			</div>
			
			<div class="col-md-6" id="page_nav_area">
				
			</div>
			
		</div>
		
	</div>
	


<script type="text/javascript">
	var totalRecord; 
	var currentPage;
	$(function(){
		to_page(1);
	});
	function to_page(pn){
		$.ajax({
			url:"${APP_PATH}/emps",
			data:"pn=" + pn,
			type:"get",
			success:function(result){
				//解析并显示员工信息
				bulid_emps_table(result);
				//解析并显示分页信息
				bulid_page_info(result);
				//解析并显示分页条
				bulid_page_nav(result);
			}
		});
	}
	
	function bulid_page_nav(result){
		$("#page_nav_area").empty();
		var ul = $("<ul></ul>").addClass("pagination");
		var firstPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if(result.extend.pageInfo.hasPreviousPage == false){
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}else{
			firstPageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum-1);
			});
		}
		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
		if(result.extend.pageInfo.hasNextPage == false){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}else{
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum+1);
			});
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
		}
		ul.append(firstPageLi).append(prePageLi);
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
			var numLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
			if(result.extend.pageInfo.pageNum == item){
				numLi.addClass("active");
			}
			numLi.click(function(){
				to_page(item);
			});
			ul.append(numLi);
		});
		ul.append(nextPageLi).append(lastPageLi);
		var navEle = $("<nav><nav>").append(ul);
		navEle.appendTo("#page_nav_area");
	}
	function bulid_page_info(result){
		$("#page_info_area").empty();
		$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+" 页，总 "+result.extend.pageInfo.pages+"页，总 "+result.extend.pageInfo.total+"条记录");
		
		totalRecord = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
	}
	function bulid_emps_table(result){
		$("#emps_table tbody").empty();
		var emps = result.extend.pageInfo.list;
		$.each(emps,function(index,item){
			
			var checkbox = $("<td><input type='checkbox' class='check_item'/></td>");
			
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
			var emailTd = $("<td></td>").append(item.email);
			var departName = $("<td></td>").append(item.department.deptName);
			var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append("编辑")
			.append($("<span></span>").addClass("glyphicon glyphicon-pencil"));
			
			editBtn.attr("edit_id",item.empId);
			
			var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append("删除")
			.append($("<span></span>").addClass("glyphicon glyphicon-trash"));
			delBtn.attr("del_id",item.empId);
			
			
			var optionTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
			$("<tr></tr>").append(checkbox).
			append(empIdTd).append(empNameTd).
			append(genderTd).append(emailTd).
			append(departName).append(optionTd).appendTo("#emps_table tbody");
		});
	}
	
	function reset_form(ele){
		//清空数据
		$(ele)[0].reset();
		//清除表单样式
		$(ele).find("*").removeClass("has-success has-error");
		$(ele).find(".help-block").text("");
	}
	
	$("#emp_add_modal_btn").click(function(){
		//$("#empAddModal form")[0].reset();	//重置表单数据
		reset_form("#empAddModal form");
		
		getDepts("#empAddModal select");
		$("#empAddModal").modal({
			backdrop:"static"
		});
	});
	
	function getDepts(ele){
		
		$(ele).empty();
		
		$.ajax({
			url:"${APP_PATH}/depts",
			type:"get",
			success:function(result){
				$.each(result.extend.depts,function(){
					var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
					optionEle.appendTo(ele);
				});
			}
		});
	}
	
	function validate_add_form(){
		var empName = $("#empName_add_input").val();
		var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
		if(!regName.test(empName)){
			show_validate_msg("#empName_add_input","fail","用户名可以是2-5位中文或者6-16位英文或者数字的组合")
			return false;
		}else{
			show_validate_msg("#empName_add_input","success","");
		}
		
		var email = $("#email_add_input").val();
		var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(!regEmail.test(email)){
			show_validate_msg("#email_add_input","fail","邮件格式不正确");
			return false;
		}else{
			show_validate_msg("#email_add_input","success","");
		}
		return true;
	}
	
	function show_validate_msg(ele,state,msg){
		$(ele).parent().removeClass("has-success has-error");
		if(state=="success"){
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text(msg);
		}else{
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}
	}
	
	$("#empName_add_input").change(function(){
		var empName = this.value;
		$.ajax({
			url:"${APP_PATH}/checkuser",
			type:"POST",
			data:"empName=" + empName,
			success:function(result){
				if(result.code == 100){
					show_validate_msg("#empName_add_input","success","用户名可用");
					$("#emp_save_btn").attr("ajax-va","success");
				}else{
					show_validate_msg("#empName_add_input","fail",result.extend.va_msg);
					$("#emp_save_btn").attr("ajax-va","fail");
				}
			}
		});
	});
	
	
	$("#emp_save_btn").click(function(){
		if(!validate_add_form()){
			return false;
		} 
		
		if($(this).attr("ajax-av")=="fail"){
			return false;
		}
		
		$.ajax({
			url:"${APP_PATH}/emp",
			type:"POST",
			data:$("#empAddModal form").serialize(),
			success:function(result){
				if(result.code == 100){
					$("#empAddModal").modal("hide");
					to_page(totalRecord);
				}else{
					//显示失败信息
					if(undefined != result.extend.errorFields.email){
						show_validate_msg("#email_add_input","fail",result.extend.errorFields.email);
					}
					if(undefined != result.extend.errorFields.empName){
						show_validate_msg("#empName_add_input","fail",result.extend.errorFields.empName);
					}
				}
			}
		});
	});
	
	
	$(document).on("click",".edit_btn",function(){
		getDepts("#empUpdateModal select");
		getEmp($(this).attr("edit_id"));
		$("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
		$("#empUpdateModal").modal({
			backdrop:"static"
		});
	});
	
	function getEmp(id){
		$.ajax({
			url:"${APP_PATH}/emp/"+id,
			type:"get",
			success:function(result){
				var empData = result.extend.emp;
				$("#empName_update_static").text(empData.empName);
				$("#email_update_input").val(empData.email);
				$("#empUpdateModal input[name=gender]").val([empData.gender]);
				$("#empUpdateModal select").val([empData.dId]);
			}
		});
	}
	
	$("#emp_update_btn").click(function(){
		var email = $("#email_update_input").val();
		var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(!regEmail.test(email)){
			show_validate_msg("#email_update_input","fail","邮件格式不正确");
			return false;
		}else{
			show_validate_msg("#email_update_input","success","");
		}
		
/* 		方式一   发送PUT请求   
		$.ajax({
			url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
			type:"POST",
			data:$("#empUpdateModal form").serialize() + "&_method=PUT",
			success:function(result){
				alert(result.msg);
			}
		}); */
		
		//添加spring 的org.springframework.web.filter.HttpPutFormContentFilter的过滤器
		$.ajax({
			url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
			type:"PUT",
			data:$("#empUpdateModal form").serialize(),
			success:function(result){
				//alert(result.msg);
				$("#empUpdateModal").modal("hide");
				//调回本页面
				to_page(currentPage);
			}
		});
		
	});
	
	//单个删除
	$(document).on("click",".delete_btn",function(){
		var empName = $(this).parents("tr").find("td:eq(1)").text();
		
		var empId = $(this).attr("del_id");
		
		if(confirm("确认删除【"+empName+"】吗？")){
			
			$.ajax({
				url:"${APP_PATH}/emp/"+empId,
				type:"DELETE",
				success:function(result){
					to_page(currentPage);
				}
			});
			
		}
	});
	
	//全选  全不选
	$("#check_all").click(function(){
		//attr 修改自定的属性的值
		//prop 修改原生的dom属性
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
	
	$(document).on("click",".check_item",function(){
		var flag = $(".check_item:checked").length == $(".check_item").length;
		$("#check_all").prop("checked",flag);
	});
	
	$("#emp_delete_all_btn").click(function(){
		var empNames = "";
		var empIds = "";
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
			empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
		});
		
		empNames = empNames.substring(0,empNames.length - 1);
		empIds = empIds.substring(0,empIds.length - 1);
		if(confirm("确认删除【"+empNames+"】吗？")){
			$.ajax({
				url:"${APP_PATH}/emp/"+empIds,
				type:"DELETE",
				data:"",
				success:function(result){
					to_page(currentPage);
				}
			});
		}
		
		
		
	});
	
	
</script>
</body>
</html>