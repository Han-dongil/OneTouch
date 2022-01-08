package com.onetouch.web.pdt.plan.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.onetouch.web.pdt.plan.service.PlanService;

@Controller
public class PlanController {
	
	@Autowired PlanService sevice;
	
	@RequestMapping("pdtList")
	public String ordList() {

		return "tiles/pdt/pdtPlanList";
	}
	
	
}
