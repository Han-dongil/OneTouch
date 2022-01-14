package com.onetouch.web.pdt.work.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.pdt.work.service.WorkService;

@Controller
public class WorkController {
	@Autowired WorkService service;
	
	@RequestMapping("WorkList")
	public String pdtListPage() {
		
		return "tiles/pdt/workInstrList";
		
	}
	
	@ResponseBody
	@GetMapping("findWorkList")
	public List<WorkVO> findWorkList(){
		return service.workList();
	}

	@ResponseBody
	@GetMapping("modalPlanList")
	public Map<String,Object> modalPlanList(){
		System.out.println("dddd");
		Map<String,Object> map=new HashMap<>();
		map.put("contents",service.planListView());
		Map<String,Object> map2=new HashMap<>();
		map2.put("data", map);
		map2.put("result",true);
		
		return map2;
	}
	
	
}
