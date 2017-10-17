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
 * ����Ա��CRUD����
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeServie;
	
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//�����ҳ���
		PageHelper.startPage(pn,5); //����ҳ��    ÿҳ��ʾ�Ĵ�С
//		startpage��������ŵĲ�ѯ����һ����ҳ��ѯ
		List<Employee> employees = employeeServie.getAll();
		
		
		PageInfo page = new PageInfo(employees,5);//���� ��ѯ��������   ��ϵ��ʾ��ҳ��
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
