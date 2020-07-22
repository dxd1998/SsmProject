package com.dxd.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dxd.pojo.Person;
import com.dxd.service.PersonService;
import com.dxd.utils.Pager;

public class DemoTest {
	public static void main(String[] args) {
                //测试
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		PersonService ps = (PersonService)context.getBean("personService");
		Map<String,Object> map = new HashMap<>();
		Pager pager = new Pager(6,5,1);
		map.put("pLoginName", "");
		map.put("dId", "");
		map.put("pager", pager);
		List<Person> list = ps.getPerson(map);
		System.out.println(list.size());
		for(Person per : list) {
			System.out.println(per.getpName());
		}
	}
}
