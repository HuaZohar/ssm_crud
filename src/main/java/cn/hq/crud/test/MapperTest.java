package cn.hq.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.hq.crud.bean.Department;
import cn.hq.crud.bean.Employee;
import cn.hq.crud.dao.DepartmentMapper;
import cn.hq.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession; 
	
	@Test
	public void testCURD() {
		System.out.println(departmentMapper);
		
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
		
		
//		employeeMapper.insert(new Employee(null,"bob","M","zzh@km.com",1));
		
		
		
		//配置批量的sqlSession
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		
		for(int i = 0; i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0,5);
			employeeMapper.insertSelective(new Employee(null,uid,"M",uid+"@km.com",1));
		}
		
	}
}
