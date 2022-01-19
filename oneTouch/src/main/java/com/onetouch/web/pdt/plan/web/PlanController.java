package com.onetouch.web.pdt.plan.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.bom.dao.BomVO;
import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.plan.service.PlanService;
import com.onetouch.web.zzz.dao.ModifyVO;

@Controller
public class PlanController {
	@Autowired PlanService service;

	@RequestMapping("PlanList")
	public String pdtListPage() {
		return "tiles/pdt/pdtPlanList";
	}
	@ResponseBody
	@GetMapping("pdtPlanlist/{nowPhs}")
	public List<PlanVO> pdtList(@PathVariable String nowPhs) {
		System.out.println(nowPhs);
		return service.list(nowPhs);
	}
	@ResponseBody
	@PostMapping("pdtPlanDtllist")
	public List<PlanVO> pdtPlanDtllist(PlanVO vo){
		String no=vo.getOrdShtNo();
//		System.out.println(no);
//		Map<String,Object> map=new HashMap<>();
//		map.put("contents", service.selectDtl(no));
//		Map<String,Object> maps=new HashMap<>();
//		maps.put("result",true);
//		maps.put("data", map);
		return service.selectDtl(no);
	}
	@ResponseBody
	@PostMapping("modifyData")
	public String modifyData(@RequestBody ModifyVO<PlanVO> list){
		service.insertPlan(list);
		return "a"; 
	}
	@ResponseBody
	@GetMapping("prdNameList/{prdCd}")
	public List<PlanVO> prdList(@PathVariable String prdCd){
		return service.findPrcCd(prdCd);
	}
	//lot별 재고조회
	@ResponseBody
	@PostMapping("lotCntList")
	public List<PlanVO> lotCntList(@RequestBody PlanVO vo){
		return service.lotCntSelect(vo);
	}
	@ResponseBody
	@PostMapping("planDtlInsert")
	public String planDtlInsert(@RequestBody Map<String,List<PlanVO>> map){
		System.out.println(map.get("detail"));
		System.out.println(map.get("plan"));
		
		//System.out.println(list);
		service.insertPlanDtl(map);
		return "a";
	}
	@ResponseBody
	@GetMapping("prdCdFind")
	public List<PrdVO> prdCdFind(){
		return service.prdCdFind();
	}

	@ResponseBody
	@GetMapping("prcCdFind/{prdCd}")
	public List<BomVO> prcCdFind(@PathVariable String prdCd){
		PlanVO vo=new PlanVO();
		vo.setPrdCd(prdCd);
		return service.prcCdFind(vo);
	}
	@ResponseBody
	@PostMapping("addInsertPlan")
	public void addInsertPlan(@RequestBody Map<String,List<PlanVO>> map) {
		System.out.println(map);
		service.addInsertPlan(map);
	}
	@ResponseBody
	@GetMapping("lotCdFind/{prcCd}/{prdCd}")
	public List<PlanVO> lotCdFind(@PathVariable String prcCd ,@PathVariable String prdCd){
		PlanVO vo=new PlanVO();
		vo.setPrcCd(prcCd);
		vo.setPrdCd(prdCd);
		return service.addPlanLotSelect(vo);
	}
 }
