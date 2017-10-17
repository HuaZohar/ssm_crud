package cn.hq.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.hq.crud.bean.Employee;
import cn.hq.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * ��ѯ����Ա������
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	
}
