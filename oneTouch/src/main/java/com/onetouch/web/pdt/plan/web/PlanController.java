package com.onetouch.web.pdt.plan.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.plan.service.PlanService;

@Controller
public class PlanController {
	
	@Autowired PlanService service;
	
	@RequestMapping("PlanList")
	public String pdtListPage() {

		return "tiles/pdt/pdtPlanList";
	}
	
	@ResponseBody
	@GetMapping("pdtPlanlist")
	public Map<String,Object> pdtList() {
	Map<String,Object> map=new HashMap<>();
	map.put("contents", service.list());
	
	Map<String,Object> maps=new HashMap<>();
	maps.put("result",true);
	maps.put("data", map);
	
		
		return maps;
	}
	
	@ResponseBody
	@PostMapping("pdtPlanDtllist")
	public Map<String,Object> pdtPlanDtllist(@RequestBody Map<String,String> vo){
		String no=vo.get("ordShtNo");
		System.out.println(no);
		Map<String,Object> map=new HashMap<>();
		map.put("contents", service.selectDtl(no));
		
		Map<String,Object> maps=new HashMap<>();
		maps.put("result",true);
		maps.put("data", map);
		return maps;
	}
	
	@ResponseBody
	@PostMapping("modifyData")
	public List<PlanVO> modifyData(Map<String,List<PlanVO>> vo){
		
		
		
		return null; 
	}
	
}
