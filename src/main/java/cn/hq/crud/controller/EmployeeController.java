package cn.hq.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.hq.crud.bean.Employee;
import cn.hq.crud.bean.Msg;
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
	
	
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids) {
		
		if(ids.contains("-")) {
			List<Integer> id_list = new ArrayList<Integer>();
			String[] idArray = ids.split("-");
			for(String id :idArray) {
				id_list.add(Integer.parseInt(id));
			}
			employeeServie.deleteBatch(id_list);
		}else {
			Integer id = Integer.parseInt(ids);
			employeeServie.deleteEmpById(id);
		}
		return Msg.success();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)  //注意此处的empId需与Employee对象中的empId名称一致
	public Msg saveEmp(Employee employee) {
		employeeServie.updateEmp(employee);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable(value="id")Integer id) {
		Employee employee = employeeServie.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam(value="empName")String empName) {
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})"; 
		if(!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}
		boolean b = employeeServie.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	/**
	 * 支持JSR303校验
	 * 导入hibernate-validator jar包
	 * @param employee
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError fieldError : fieldErrors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeServie.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	
	/**
	 * 需要导入Jackson jar包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1") Integer pn) {
		//引入分页插件
		PageHelper.startPage(pn,5); //传入页码    每页显示的大小
		//startpage后面紧跟着的查询就是一个分页查询
		List<Employee> employees = employeeServie.getAll();
		PageInfo page = new PageInfo(employees,5);//传入 查询出的数据   联系显示的页数
		return Msg.success().add("pageInfo", page);
	}
	
	/*
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//引入分页插件
		PageHelper.startPage(pn,5); //传入页码    每页显示的大小
		//startpage后面紧跟着的查询就是一个分页查询
		List<Employee> employees = employeeServie.getAll();
		
		
		PageInfo page = new PageInfo(employees,5);//传入 查询出的数据   联系显示的页数
		model.addAttribute("pageInfo", page);
		return "list";
	}
	*/
	
	
}
