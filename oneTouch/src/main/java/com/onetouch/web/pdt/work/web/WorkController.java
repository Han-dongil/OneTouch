package com.onetouch.web.pdt.work.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.plan.service.PlanService;
import com.onetouch.web.pdt.work.dao.WorkVO;
import com.onetouch.web.pdt.work.service.WorkService;

@Controller
public class WorkController {
	@Autowired WorkService service;
	@Autowired PlanService planService;
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
	public List<PlanVO> modalPlanList(){
		/*
		 * System.out.println("dddd"); Map<String,Object> map=new HashMap<>();
		 * map.put("contents",service.planList()); Map<String,Object> map2=new
		 * HashMap<>(); map2.put("data", map); map2.put("result",true);
		 */
		return service.planList();
	}
	
	@ResponseBody
	@GetMapping("planDtlList/{planNo}")
	public List<PlanVO> modalPlanList(@PathVariable String planNo){
		
		
		return service.planListView(planNo);
	}
	//자재 데이터 
	@ResponseBody
	@PostMapping("planDtlMtr")
	public List<PlanVO> planDtlMtr(@RequestBody PlanVO vo){
		
		return service.findLotMtrCnt(vo);
	}
	//공정데이터
	@ResponseBody
	@PostMapping("planDtlPrc")
	public List<PlanVO> planDtlPrc(@RequestBody PlanVO vo){
		return planService.findPrcCd(vo.getPrdCd());
	}
	
}
