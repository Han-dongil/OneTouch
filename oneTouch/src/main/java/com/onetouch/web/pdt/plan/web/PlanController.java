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
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.pdt.ord.dao.OrdMapper;
import com.onetouch.web.pdt.plan.dao.PlanMapper;
import com.onetouch.web.pdt.plan.dao.PlanVO;
import com.onetouch.web.pdt.plan.service.PlanService;
import com.onetouch.web.zzz.dao.ModifyVO;
@RequestMapping("pdt/")
@Controller
public class PlanController {
	@Autowired PlanService service;
	@Autowired PlanMapper mapper;
	@Autowired OrdMapper ordMapper;

	@RequestMapping("PlanList")
	public String pdtListPage() {
		return "tiles/pdt/pdtPlanList";
	}
	@ResponseBody
	@GetMapping("pdtPlanlist/{nowPhs}")
	public List<PlanVO> pdtList(@PathVariable String nowPhs) {
		System.out.println(nowPhs);
		Map<String,String> vo =new HashMap<String,String>();
		vo.put("nowPhs", nowPhs);
		return service.list(vo);
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
		PlanVO vo=new PlanVO();
		vo.setPrcCd(prdCd);
		return service.findPrcCd(vo);
	}
	//lot별 재고조회
	@ResponseBody
	@PostMapping("lotCntList")
	public List<PlanVO> lotCntList(@RequestBody PlanVO vo){
		return service.lotCntSelect(vo);
	}
	@ResponseBody
	@PostMapping("planDtlInsert")
	public void planDtlInsert(@RequestBody Map<String,List<PlanVO>> map){
		System.out.println("zzzzzzzzzz");
		System.out.println(map.get("lot").get(0).getMtrLot());
		service.insertPlanDtl(map);
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
	@GetMapping("lotCdFind/{prdCd}/{prcCd}")
	public List<PlanVO> lotCdFind(@PathVariable String prdCd ,@PathVariable String prcCd){
		System.out.println(prcCd +","+ prdCd);
		PlanVO vo=new PlanVO();
		vo.setPrcCd(prcCd);
		vo.setPrdCd(prdCd);
		//System.out.println(service.addPlanLotSelect(vo));
		return service.addPlanLotSelect(vo);
	}
	
	//prd코드로 라인번호 가져와서 / 기준으로 split함
	@ResponseBody
	@GetMapping("lineNoFind/{prdCd}")
	public List<PlanVO> lineNoFind(@PathVariable String prdCd){
		
		return service.findLineNo(prdCd);
	}
	
	@ResponseBody
	@GetMapping("lotLineFind/{lineNo}")
	public List<InfoVO> prcLineFind(@PathVariable String lineNo,PlanVO vo){
		vo.setLineNo(lineNo);
		
		
		return service.prcLineFine(vo);
	}
	
	@ResponseBody
	@GetMapping("planNoFind")
	public PlanVO planNoFind() {
		System.out.println(mapper.findPlanSeq());
		return mapper.findPlanSeq();
	}
	@ResponseBody
	@GetMapping("ordShtSelect/{ordShtNo}")
	public List<PlanVO> ordShtSelect(@PathVariable String ordShtNo){
		System.out.println(ordShtNo);
		return ordMapper.ordShtSelect(ordShtNo);
	}
 }
