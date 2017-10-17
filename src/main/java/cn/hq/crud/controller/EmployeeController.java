package cn.hq.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.hq.crud.bean.Employee;
import cn.hq.crud.service.EmployeeService;

/**
 * 处理员工CRUD操作
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeServie;
	
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//引入分页插件
		PageHelper.startPage(pn,5); //传入页码    每页显示的大小
//		startpage后面紧跟着的查询就是一个分页查询
		List<Employee> employees = employeeServie.getAll();
		
		
		PageInfo page = new PageInfo(employees,5);//传入 查询出的数据   联系显示的页数
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
