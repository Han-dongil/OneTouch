package com.onetouch.web.pdt.plan.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.pdt.plan.dao.PlanMapper;
import com.onetouch.web.pdt.plan.dao.PlanVO;

@RequestMapping("/pdt/")
@Controller
public class PlanViewController {

	@Autowired PlanMapper mapper;
	
	@RequestMapping("planListView")
	public String ordList() {

		return "tiles/pdt/pdtPlanListView";
	}
	
	@ResponseBody
	@RequestMapping("planSearchList")
	public List<PlanVO> planSearchList(@RequestBody Map<String,String> map){
		System.out.println("11111");
		return mapper.list(map);
	}
	@ResponseBody
	@RequestMapping("planDtlList")
	public List<PlanVO> planDtlList(@RequestBody PlanVO vo){
		System.out.println("11111");
		//vo.setPrdCd("");
		return mapper.pdtPlanDtllist(vo);
	}
	
}
