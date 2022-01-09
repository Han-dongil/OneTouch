package com.onetouch.web.pdt.plan.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.ord.dao.OrdVO;
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
	public List<PlanVO> pdtList() {
		
		
		return service.list();
	}
	
	@ResponseBody
	@GetMapping("pdtPlanDtllist/{no}")
	public List<PlanVO> pdtPlanDtllist(@PathVariable String no){
		return service.selectDtl(no);
	}
	
}
