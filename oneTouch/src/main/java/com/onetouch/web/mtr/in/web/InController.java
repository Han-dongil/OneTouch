
package com.onetouch.web.mtr.in.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.mtr.in.dao.InSearchVO;
import com.onetouch.web.mtr.in.dao.InVO;
import com.onetouch.web.mtr.in.service.InService;

@Controller
public class InController {

	@Autowired InService service;
	
	@RequestMapping("inList")
	public String inList() {
		return "tiles/mtr/mtrInList";
	}
	
	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/mtrInList") public List<InVO> list(){ List<InVO> list= new
	 * ArrayList<>(); list =service.list(); return list; }
	 */
	
	//조건조회 grid
	@ResponseBody
	@RequestMapping("/mtrInList")
	public Map<String,Object> select(@RequestBody InSearchVO in){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		System.out.println(in);
		data.put("result", true);
		datas.put("contents", service.select(in));
		data.put("data", datas);
		return data;
	}
	
	
	@ResponseBody
	@PostMapping("/mtrModify")
	public List<InSearchVO> modify(InSearchVO in){
		/* System.out.println("in: "+in); */
		List<InSearchVO> list= new ArrayList<>();
		list =service.select(in);
		/* System.out.println("list : " + list); */
		return list;
	}
	
	@ResponseBody
	@PostMapping("/mtrDelRow")
	public List<InVO> delete(List<InVO> list){
		service.delete(list);
		System.out.println("list : " + list);
		return list;
	}
}
