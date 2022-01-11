
package com.onetouch.web.mtr.in.web;

import java.util.HashMap;
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
import com.onetouch.web.zzz.dao.ModifyVO;

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
	public void select(InSearchVO in){
		Map<String,Object> datas = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
		System.out.println(in);
		data.put("result", true);
		datas.put("contents", service.select(in));
		data.put("data", datas);
	}
	
	
	@ResponseBody
	@PostMapping("/mtrModify")
	public void modify(@RequestBody ModifyVO<InVO> mvo){
		 service.modify(mvo);
	}
	
}
